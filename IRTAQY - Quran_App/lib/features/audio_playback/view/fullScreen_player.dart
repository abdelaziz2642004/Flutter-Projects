import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/features/audio_playback/view/AudioControls.dart';
import 'package:quran_app/features/audio_playback/view/AudioSlider.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';
import 'package:quran_app/features/reciter_selection/view_model/selectedReciterProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/selectedSurahProvider.dart';

import '../../../core/widgets/colors.dart';
import '../../../core/widgets/theme_provider.dart';

class FullScreenPlayer extends ConsumerStatefulWidget {
  // final AudioService audioService;
  // final Reciter reciter;
  // final Surah surah;

  const FullScreenPlayer({
    // required this.audioService,
    super.key,
    // required this.reciter,
    // required this.surah,
  });

  @override
  ConsumerState<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends ConsumerState<FullScreenPlayer> {
  @override
  void initState() {
    super.initState();
    ref.read(audioServiceProvider).redo(setState, ref);
  }

  @override
  Widget build(BuildContext context) {
    final selectedReciter = ref.watch(selectedReciterProvider);
    final selectedSurah = ref.watch(selectedSurahProvider);
    final isDarkMode = ref.watch(themeProvider) == Brightness.dark;
    if (selectedReciter != null && selectedSurah != null) {
      return PopScope(
        onPopInvokedWithResult:
            (didPop, result) => {
              if (didPop)
                {ref.read(audioServiceProvider).cancelSubscriptions()},
            },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color:
                    isDarkMode ? CustomColors.darkText : CustomColors.lightText,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'القرآن الكريم',
              style: TextStyle(
                color:
                    isDarkMode ? CustomColors.darkText : CustomColors.lightText,

                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: selectedReciter.imageUrl,
                        // again , compact or full will never happen if these are null
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Text(
                      'سورة ${selectedSurah.nameArabic} ',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      selectedReciter.nameArabic,
                      style: const TextStyle(fontSize: 16),
                    ),
                    AudioSlider(
                      rebuildParent: () {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    const AudioControls(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
