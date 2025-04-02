import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Surah.dart';
import 'package:quran_app/core/widgets/app_bar_widget.dart';
import 'package:quran_app/features/audio_playback/view/compact_player.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioProvider.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';
import 'package:quran_app/features/audio_playback/view_model/CompactVisibilityProvider.dart';
import 'package:quran_app/features/reciter_selection/view_model/selectedReciterProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/selectedSurahProvider.dart';

import '../../../core/Models/AudioFile.dart';
import '../../../core/Models/Reciter.dart';
import '../../../core/view_models/download_manager.dart';
import '../../../core/widgets/custom_list_tile.dart';
import '../../home/view_model/home_view_model.dart';

class DownloadsSurahScreen extends ConsumerStatefulWidget {
  const DownloadsSurahScreen({
    super.key,
    required this.surahs,
    required this.reciter,
    required this.downloadManager,
  });

  final Reciter reciter;
  final List<Surah> surahs;
  final DownloadManager downloadManager;

  @override
  ConsumerState<DownloadsSurahScreen> createState() =>
      _DownloadsSurahScreenState();
}

class _DownloadsSurahScreenState extends ConsumerState<DownloadsSurahScreen> {
  late AudioFile? audioFile;

  int selectedSurah = 0;

  @override
  Widget build(BuildContext context) {
    final audioAsync = ref.watch(
      localAudioFileProvider((
        widget.downloadManager,
        widget.reciter.id,
        widget.surahs[selectedSurah].id,
      )),
    );
    final compactOn = ref.watch(compactAudioPlayerVisibilityProvider);

    final audioService = ref.watch(audioServiceProvider);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        color: const Color(0xfff9f6e4),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.surahs.length,
                itemBuilder: (context, index) {
                  return CustomListTile(
                    leading: Text(
                      widget.surahs[index].id.toString().trim(),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Color(0xfff9f6e4),
                      ),
                    ),
                    title: widget.surahs[index].nameSimple.trim(),
                    subtitle: widget.surahs[index].nameArabic.trim(),
                    trailing: const Icon(
                      Icons.play_circle_outline_rounded,
                      size: 30,
                    ),
                    onTap: () async {
                      // audioFile = audioAsync.value;

                      ref.read(selectedSurahProvider.notifier).state =
                          widget.surahs[index];
                      ref.read(selectedReciterProvider.notifier).state =
                          widget.reciter;
                      ref
                          .read(compactAudioPlayerVisibilityProvider.notifier)
                          .state = true;

                      try {
                        final audioFile = await ref.read(
                          audioFileProvider((
                            widget.reciter.id,
                            widget.surahs[index].id,
                          )).future,
                        );

                        ref
                            .read(audioServiceProvider.notifier)
                            .changeAudio(audioFile, ref);
                        ref
                            .read(homeViewModelProvider.notifier)
                            .addRecentlyPlayed(
                              widget.reciter,
                              widget.surahs[index],
                            );
                        selectedSurah = index;
                      } catch (e) {}
                    },
                  );
                },
              ),
            ),

            if (compactOn) const CompactAudioPlayer(),
          ],
        ),
      ),
    );
  }
}
