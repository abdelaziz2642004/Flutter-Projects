import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/AudioFile.dart';
import 'package:quran_app/core/services/AudioService.dart';

class AudioServiceNotifier extends StateNotifier<AudioService> {
  AudioServiceNotifier(AudioFile initialAudioFile)
    : super(AudioService(currentAudioFile: initialAudioFile));

  void changeAudio(AudioFile newAudioFile, WidgetRef ref) {
    state.dispose(); // Dispose of the old service
    state = AudioService(currentAudioFile: newAudioFile);
    state.initializeAudio(ref);
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final audioServiceProvider =
    StateNotifierProvider<AudioServiceNotifier, AudioService>(
      (ref) => AudioServiceNotifier(AudioFile(audioUrl: "", surahNumber: 1)),
    );
