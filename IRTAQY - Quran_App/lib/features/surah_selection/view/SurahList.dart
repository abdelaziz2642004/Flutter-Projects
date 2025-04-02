import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Reciter.dart';
import 'package:quran_app/core/Models/Surah.dart';
import 'package:quran_app/core/widgets/custom_list_tile.dart';

import '../../../core/view_models/download_manager.dart';
import '../../../core/widgets/colors.dart';
import '../../audio_playback/view_model/AudioProvider.dart';
import '../../audio_playback/view_model/AudioServiceProvider.dart';
import '../../audio_playback/view_model/CompactVisibilityProvider.dart';
import '../../home/view_model/home_view_model.dart';
import '../../reciter_selection/view_model/selectedReciterProvider.dart';
import '../view_model/selectedSurahProvider.dart';

class Surahlist extends ConsumerStatefulWidget {
  final List<Surah> surahs;
  final Reciter reciter;

  const Surahlist({required this.surahs, super.key, required this.reciter});

  @override
  ConsumerState<Surahlist> createState() => _SurahlistState();
}

class _SurahlistState extends ConsumerState<Surahlist> {
  @override
  Widget build(BuildContext context) {
    final selectedSurah = ref.watch(selectedSurahProvider);
    final selectedReciter = ref.watch(selectedReciterProvider);
    final downloadManager = context.watch<DownloadManager>();

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.surahs.length,
      itemBuilder: (context, index) {
        final surah = widget.surahs[index];
        final dowmloaded = downloadManager.getDownloads();

        return CustomListTile(
          onTap: () async {
            // First update all the state providers
            ref.read(selectedSurahProvider.notifier).state = surah;
            ref.read(selectedReciterProvider.notifier).state = widget.reciter;
            ref.read(compactAudioPlayerVisibilityProvider.notifier).state =
                true;

            try {
              final audioFile = await ref.read(
                audioFileProvider((widget.reciter.id, surah.id)).future,
              );
              ref
                  .read(homeViewModelProvider.notifier)
                  .addRecentlyPlayed(widget.reciter, surah);
              ref
                  .read(audioServiceProvider.notifier)
                  .changeAudio(audioFile, ref);
            } catch (err) {}
          },
          title: surah.nameSimple,
          subtitle: surah.nameArabic,
          trailing:
              dowmloaded.keys.contains(surah.id)
                  ? const Icon(
                    Icons.download_done_rounded,
                    size: 25,
                    color: CustomColors.lightText,
                  )
                  : GestureDetector(
                    child: const Icon(
                      Icons.download_outlined,
                      size: 25,
                      color: CustomColors.lightSecondaryText,
                    ),
                    onTap: () {
                      downloadManager.downloadSurah(
                        selectedSurah!.id,
                        selectedReciter!.id,
                      );
                    },
                  ),
        );
      },
    );
  }
}

// back before 10s --> previous surah , if at el fatha ? restart 3la tool
// else restart the surah
// next next surah , if at el nas ? go to el fatha , restart playlist
