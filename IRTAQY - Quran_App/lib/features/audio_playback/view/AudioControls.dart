import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/core/widgets/colors.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';
import 'package:quran_app/features/audio_playback/view_model/loopModeBooleanProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/selectedSurahProvider.dart';

import '../../../core/view_models/download_manager.dart';
import '../../../core/view_models/download_states.dart';
import '../../reciter_selection/view_model/selectedReciterProvider.dart';

class AudioControls extends ConsumerStatefulWidget {
  // final AudioService audioService;

  const AudioControls({super.key});

  @override
  ConsumerState<AudioControls> createState() => _AudioControlsState();
}

class _AudioControlsState extends ConsumerState<AudioControls> {
  @override
  Widget build(BuildContext context) {
    final audioService = ref.watch(audioServiceProvider);
    final selectedSurah = ref.watch(selectedSurahProvider);
    final selectedReciter = ref.watch(selectedReciterProvider);
    final downloadManager = context.watch<DownloadManager>();

    if (selectedSurah == null || selectedReciter == null) {
      return Container();
    }

    downloadManager.isSurahDownloaded(selectedReciter.id, selectedSurah.id);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.loop,
            size: 30,
            color:
                ref.watch(loopModeProvider)
                    ? CustomColors.lightCard
                    : CustomColors.lightText,
          ),
          onPressed: () {
            final currentState = ref.read(loopModeProvider);
            ref.read(loopModeProvider.notifier).state = !currentState;

            final messenger = ScaffoldMessenger.of(context);
            messenger.removeCurrentSnackBar(); // Remove any existing SnackBar
            messenger.showSnackBar(
              SnackBar(
                content: Text(
                  !currentState ? 'Loop mode enabled' : 'Loop mode disabled',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: !currentState ? Colors.green : Colors.red,
                duration: const Duration(seconds: 1), // Set a short duration
              ),
            );
          },
        ),

        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.skip_previous_rounded,
            size: 30,
            color:
                selectedSurah.id == 1
                    ? const Color.fromARGB(33, 198, 195, 195)
                    : null, // Grey out when disabled
          ),
          onPressed:
              selectedSurah.id == 1
                  ? null
                  : () {
                    // Disable when id is 1
                    setState(() {
                      audioService.previous(ref);
                    });
                  },
        ),

        StreamBuilder(
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
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                size: 50,
              ),
              onPressed:
                  isBuffering
                      ? null
                      : () {
                        if (audioService.audioPlayer.playing) {
                          audioService.audioPlayer.pause();
                        } else {
                          audioService.audioPlayer.play();
                        }
                      },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next_rounded, size: 30),
          onPressed: () {
            setState(() {
              audioService.next(ref);
            });
          },
        ),
        const Spacer(),
        BlocBuilder<DownloadManager, DownloadStates>(
          builder: (context, state) {
            if (state is DownloadedState && state.surahId == selectedSurah.id) {
              return const Icon(
                Icons.download_done_rounded,
                size: 30,
                color: CustomColors.lightCard,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.download_outlined, size: 30),
                onPressed: () {
                  downloadManager.downloadSurah(
                    selectedSurah.id,
                    selectedReciter.id,
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
