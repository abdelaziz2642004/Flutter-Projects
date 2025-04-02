import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';

class AudioSlider extends ConsumerStatefulWidget {
  const AudioSlider({super.key, required this.rebuildParent});

  final Function rebuildParent;

  @override
  ConsumerState<AudioSlider> createState() => _AudioSliderState();
}

class _AudioSliderState extends ConsumerState<AudioSlider> {
  @override
  Widget build(BuildContext context) {
    final audioService = ref.read(audioServiceProvider);
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Text(audioService.formatDuration(audioService.position)),
            const Spacer(),
            Text(
              audioService.formatDuration(audioService.totalSongLength),
            ), // still
            const SizedBox(width: 20),
          ],
        ),
        Slider(
          value: audioService.position.inSeconds.toDouble(),
          max:
              (audioService.totalSongLength.inSeconds > 0)
                  ? audioService.totalSongLength.inSeconds.toDouble()
                  : 1,
          onChanged: (value) async {
            await audioService.audioPlayer.player.seek(
              // jump to that second :D
              Duration(seconds: value.toInt()),
            );
            widget.rebuildParent();
          },
          activeColor: const Color(0xff56905e),
          inactiveColor: Colors.grey[300],
        ),
      ],
    );
  }
}
