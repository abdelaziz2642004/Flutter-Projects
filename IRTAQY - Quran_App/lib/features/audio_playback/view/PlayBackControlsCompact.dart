import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';

class PlaybackControls extends ConsumerWidget {
  final Function rebuild;

  const PlaybackControls({super.key, required this.rebuild});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioService = ref.watch(audioServiceProvider);
    return StreamBuilder<PlayerState>(
      stream: audioService.audioPlayer.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;

        bool isBuffering =
            processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering;

        return IconButton(
          icon: Icon(
            audioService.audioPlayer.playing
                ? Icons.pause_circle_filled
                : Icons.play_circle_fill,
            size: 35,
            color: Colors.white,
          ),
          onPressed:
              isBuffering
                  ? null
                  : () {
                    audioService.audioPlayer.playing
                        ? audioService.audioPlayer.pause()
                        : audioService.audioPlayer.play();
                    audioService.isPlaying =
                        false; // it is the same object everywhere :D
                    rebuild();
                  },
        );
      },
    );
  }
}
