import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Reciter.dart';
import 'package:quran_app/core/widgets/custom_text_form_field.dart';
import 'package:quran_app/features/audio_playback/view/compact_player.dart';
import 'package:quran_app/features/audio_playback/view_model/CompactVisibilityProvider.dart';
import 'package:quran_app/features/surah_selection/view/SurahList.dart';
import 'package:quran_app/features/surah_selection/view_model/SurahsProvider.dart';

import '../../../core/view_models/download_manager.dart';
import '../../../core/widgets/colors.dart';
import '../view_model/selectedSurahProvider.dart';

class SurahListScreen extends ConsumerStatefulWidget {
  const SurahListScreen({super.key, required this.reciter});

  final Reciter reciter;

  @override
  ConsumerState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends ConsumerState<SurahListScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final surahsAsync = ref.watch(surahsProvider);
    final compactOn = ref.watch(compactAudioPlayerVisibilityProvider);
    // ref.watch(audioFileProvider);
    final downloadManager = context.watch<DownloadManager>();
    final dowmloaded = downloadManager.getDownloads();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select a Surah",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: CustomColors.darkText,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.darkAppBar,
        foregroundColor: CustomColors.lightText,
        actions: [
          dowmloaded.keys.length == 114
              ? const SizedBox()
              : IconButton(
                icon: const Icon(
                  Icons.download_outlined,
                  size: 25,
                  color: CustomColors.lightSecondaryText,
                ),
                onPressed: () {
                  downloadManager.downloadAllSurahs(
                    ref.watch(selectedSurahProvider)!.id,
                  );
                },
              ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: CustomTextFormFild(
              hint: "Search Surah",
              prefixIcon: Icons.search,
              filled: true,
              suffixIcon: searchQuery.isEmpty ? null : Icons.cancel_sharp,
              onTapSuffixIcon: () {
                setState(() {
                  searchQuery = "";
                });
              },
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: surahsAsync.when(
              data: (surahs) {
                final filteredSurahs =
                    surahs.where((surah) {
                      final query = searchQuery.toLowerCase();
                      return surah.nameSimple.toLowerCase().contains(query) ||
                          surah.nameArabic.contains(query);
                    }).toList();
                return Surahlist(
                  surahs: filteredSurahs,
                  reciter: widget.reciter,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) {
                return Center(
                  child: Text(
                    "$err",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
                // throw Exception(stack);
              },
            ),
          ),
          if (compactOn) const CompactAudioPlayer(),
        ],
      ),
    );
  }
}
