import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:quran_app/core/view_models/recitation_details.dart';

import '../Models/AudioFile.dart';
import '../services/ApiService.dart';
import './download_states.dart';

class DownloadManager extends Cubit<DownloadStates> {
  DownloadManager() : super(DownloadInitialState());

  final RecitationDetails _recitationDetails = RecitationDetails.instance;
  http.Client? _client;
  StreamSubscription<List<int>>? _subscription;
  bool _isCanceled = false;

  Future<AudioFile> getAudio(int reciterId, int surahId) async {
    final dir = await getDownloadsDirectory();

    final fileType = _recitationDetails
        .details[reciterId.toString()]?["downloads"]
        .keys
        .firstWhere((String key) => key.contains(surahId.toString()));

    final String surahFileName = "${dir!.path}/$reciterId-$fileType";
    if (File(surahFileName).existsSync()) {
      return AudioFile(surahNumber: surahId, audioUrl: surahFileName);
    }
    throw Exception("Audio file not found");
  }

  Map<int, List<int>> getDownloads() {
    Map<int, List<int>> downloadsMap = {};

    _recitationDetails.details.forEach((reciterId, reciterData) {
      final downloads = reciterData['downloads'] as Map<dynamic, dynamic>;
      downloadsMap[int.parse(reciterId)] = [];
      downloads.forEach((key, value) {
        if (value == true) {
          downloadsMap[int.parse(reciterId)]?.add(int.parse(key.split(".")[0]));
        }
      });
    });

    return downloadsMap;
  }

  Future<void> isSurahDownloaded(int reciterId, int surahId) async {
    final dir = await getDownloadsDirectory();
    final extension = ".mp3"; // Adjust based on actual file extension
    final fileName = "$reciterId-$surahId$extension";
    final filePath = "${dir!.path}/$fileName";
    File(filePath).existsSync()
        ? emit(DownloadedState(surahId))
        : emit(DownloadInitialState());
  }

  /// Download a single Surah with progress tracking
  Future<void> downloadSurah(int reciterId, int surahId) async {
    _client = http.Client();
    try {
      final audioFile = await QuranApiService.fetchSurahAudio(
        reciterId,
        surahId,
      );
      final audioUrl = audioFile.audioUrl;

      final response = await _client!.send(
        http.Request('GET', Uri.parse(audioUrl)),
      );

      if (response.statusCode == 500) {
        emit(ServerErrorState("Server Error"));
        return;
      } else if (response.statusCode == 404) {
        emit(NetworkErrorState("Audio file not found"));
        return;
      }

      final dir = await getDownloadsDirectory();
      final extension = audioUrl.substring(audioUrl.lastIndexOf('.'));
      final fileName = "$reciterId-$surahId$extension";
      final filePath = "${dir!.path}/$fileName";
      final file = File(filePath);
      if (await file.exists()) {
        emit(DownloadedState(surahId));
        return;
      }

      final sink = file.openWrite();
      _subscription = response.stream.listen(
        (chunk) {
          if (_isCanceled) throw Exception("Download canceled");
          sink.add(chunk);
          emit(NotDownloadedState(surahId));
        },
        onDone: () async {
          await sink.close();
          _recitationDetails.toggleDownload(
            reciterId.toString(),
            "$surahId$extension",
          );
          emit(DownloadedState(surahId));
        },
        onError: (e) async {
          await sink.close();
          emit(StorageErrorState("Storage Error: $e"));
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(StorageErrorState("Unexpected Error"));
    }
  }

  /// Download all Surahs sequentially
  Future<void> downloadAllSurahs(int reciterId) async {
    // emit(AllDownloadingState());
    try {
      for (int surahId = 1; surahId <= 114; surahId++) {
        await downloadSurah(reciterId, surahId);
      }
      // emit(AllDownloadedState());
    } catch (e) {
      emit(StorageErrorState("Failed to download all Surahs: $e"));
    }
  }

  /// Cancel the current download
  Future<void> cancelDownload() async {
    _isCanceled = true;
    await _subscription?.cancel();
    _client?.close();
    _isCanceled = false;
    emit(DownloadInitialState());
  }

  /// Delete a specific downloaded Surah file
  Future<void> deleteSurah(String reciterId, String surahId) async {
    final dir = await getDownloadsDirectory();

    final fileType = _recitationDetails.details[reciterId]?["downloads"].keys
        .firstWhere((String key) => key.contains(surahId));

    final String surahFileName = "$reciterId-$fileType";
    final file = File("${dir!.path}/$surahFileName");

    if (await file.exists()) {
      await file.delete();
      _recitationDetails.toggleDownload(reciterId, fileType);
      emit(DownloadInitialState());
    } else {}
  }

  /// Delete all downloaded Surahs for a specific reciter
  Future<void> deleteAllSurahs(String reciterId) async {
    final dir = await getDownloadsDirectory();

    // ✅ FIXED: Correct map access syntax
    final reciterDetails = _recitationDetails.details[reciterId];

    if (reciterDetails != null && reciterDetails.length > 1) {
      final downloadMap =
          reciterDetails["download"]; // This is a Map<String, bool>
      for (var fileName in downloadMap.keys.toList()) {
        final file = File(
          "${dir!.path}/$reciterId-$fileName",
        ); // fileName already has reciterId prefix
        if (await file.exists()) {
          await file.delete();
        }
      }
      // Reset download map
      downloadMap.clear();
      _recitationDetails.savePrefs(); // Save the cleared state
    }

    emit(DownloadInitialState());
  }
}
