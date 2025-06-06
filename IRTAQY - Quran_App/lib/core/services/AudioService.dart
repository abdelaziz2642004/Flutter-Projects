import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/core/Models/Surah.dart';
import 'package:quran_app/core/services/ApiService.dart';
import 'package:quran_app/features/audio_playback/view_model/loopModeBooleanProvider.dart';
import 'package:quran_app/features/reciter_selection/view_model/selectedReciterProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/SurahsProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/selectedSurahProvider.dart';

import '../Models/AudioFile.dart';
import '../view_models/audio_handler.dart';

class AudioService {
  AudioService({required this.currentAudioFile});

  AudioFile currentAudioFile;
  final QuranAudioHandler _audioPlayer = QuranAudioHandler();

  QuranAudioHandler get audioPlayer => _audioPlayer;

  bool isPlaying = true;
  Duration totalSongLength = Duration.zero;
  Duration position = Duration.zero;

  void initializeAudio(WidgetRef ref) async {
    _setAudio(ref).then((_) => play());
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        final bool shouldLoop = ref.read(loopModeProvider);
        if (shouldLoop) {
          _setAudio(ref).then((_) => play());
          // play();
        } else {
          next(ref);
        }
      }
    });
  }

  StreamSubscription? _positionSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _playerStateSubscription;

  void redo(Function rebuildParent, WidgetRef ref) {
    _positionSubscription = _audioPlayer.positionStream.listen((p) {
      rebuildParent(() => position = p);
    });

    _durationSubscription = audioPlayer.durationStream.listen((d) {
      rebuildParent(() => totalSongLength = d ?? Duration.zero);
    });
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        final bool shouldLoop = ref.read(loopModeProvider);
        if (shouldLoop) {
          _setAudio(ref).then((_) => play());
          // play();
        } else {
          // rebuildParent(() => isPlaying = false);
          next(ref);
        }
      }
    });
  }

  Future<bool> _setAudio(WidgetRef ref) async {
    try {
      await audioPlayer.playFromUrl(currentAudioFile.audioUrl, ref);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> next(WidgetRef ref) async {
    final selectedReciter = ref.read(selectedReciterProvider);
    if (selectedReciter == null) return;

    int newSurahId = currentAudioFile.surahNumber + 1;
    if (newSurahId > 114) {
      newSurahId = 1;
    }

    final surahsAsync = ref.read(surahsProvider);
    final surahs = surahsAsync.valueOrNull;
    if (surahs == null) return;

    final Surah surah = surahs.firstWhere(
      (element) => element.id == newSurahId,
    );

    currentAudioFile = await QuranApiService.fetchSurahAudio(
      selectedReciter.id,
      newSurahId,
    );
    ref.read(selectedSurahProvider.notifier).state = surah;

    _setAudio(ref).then((_) => play());

    // ref.read(selectedSurahProvider.notifier).state = surah;
  }

  Future<void> previous(WidgetRef ref) async {
    final selectedReciter = ref.read(selectedReciterProvider);
    if (selectedReciter == null) return;

    int newSurahId = currentAudioFile.surahNumber - 1;
    if (newSurahId < 1) {
      newSurahId = 114;
    }

    final surahsAsync = ref.read(surahsProvider);
    final surahs = surahsAsync.valueOrNull;
    if (surahs == null) return;

    final Surah surah = surahs.firstWhere(
      (element) => element.id == newSurahId,
    );

    currentAudioFile = await QuranApiService.fetchSurahAudio(
      selectedReciter.id,
      newSurahId,
    );
    ref.read(selectedSurahProvider.notifier).state = surah;

    _setAudio(ref).then((_) => play());

    // ref.read(selectedSurahProvider.notifier).state = surah;
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    isPlaying = false;
  }

  Future<void> play() async {
    isPlaying = true;
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    isPlaying = false;
    await _audioPlayer.pause();
  }

  void cancelSubscriptions() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    // _audioPlayer.dispose(); // when exiting a fullscreen , this will not happen
  }

  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _audioPlayer.dispose();
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }
}
