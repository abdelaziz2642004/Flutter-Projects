import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/AudioFile.dart';
import 'package:quran_app/core/services/ApiService.dart';
import 'package:quran_app/core/view_models/download_manager.dart';

final lastFetchedAudioFileProvider = StateProvider<AudioFile?>((ref) => null);

// FutureProvider to fetch new AudioFile
final audioFileProvider = FutureProvider
    .family // change the name to " audio file updater"
    .autoDispose<AudioFile, (int, int)>((ref, params) async {
      final (reciterId, surahId) = params;
      final audioFile = await QuranApiService.fetchSurahAudio(
        reciterId,
        surahId,
      );

      // Save the fetched file in state
      ref.read(lastFetchedAudioFileProvider.notifier).state = audioFile;

      return audioFile;
    });
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quran_app/core/Models/AudioFile.dart';
// import 'package:quran_app/core/services/ApiService.dart';

// final lastFetchedAudioFileProvider =
//     StateNotifierProvider<LastFetchedAudioFileNotifier, AudioFile?>(
//       (ref) => LastFetchedAudioFileNotifier(),
//     );

// class LastFetchedAudioFileNotifier extends StateNotifier<AudioFile?> {
//   LastFetchedAudioFileNotifier() : super(null);

//   Future<void> fetchAudioFile(int reciterId, int surahId) async {
//     final audioFile = await QuranApiService.fetchSurahAudio(reciterId, surahId);
//     state = audioFile;
//   }
// }

final localAudioFileProvider =
    FutureProvider.family<AudioFile, (DownloadManager, int, int)>((
      ref,
      params,
    ) async {
      final (downloadManager, reciterId, surahId) = params;
      return await downloadManager.getAudio(reciterId, surahId);
    });
