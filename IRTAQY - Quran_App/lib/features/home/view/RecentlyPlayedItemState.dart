import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/colors.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioProvider.dart';
import 'package:quran_app/features/audio_playback/view_model/AudioServiceProvider.dart';
import 'package:quran_app/features/audio_playback/view_model/CompactVisibilityProvider.dart';
import 'package:quran_app/features/reciter_selection/view_model/selectedReciterProvider.dart';
import 'package:quran_app/features/surah_selection/view_model/selectedSurahProvider.dart';

import '../../../core/Models/Reciter.dart';
import '../../../core/Models/Surah.dart';
import '../../../core/widgets/theme_provider.dart';

class RecentlyPlayedItem extends ConsumerStatefulWidget {
  final Map<Reciter, Surah> item;

  const RecentlyPlayedItem({super.key, required this.item});

  @override
  ConsumerState<RecentlyPlayedItem> createState() => _RecentlyPlayedItemState();
}

class _RecentlyPlayedItemState extends ConsumerState<RecentlyPlayedItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the current theme mode
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final compactOn = ref.watch(compactAudioPlayerVisibilityProvider);
    final backgroundColor =
        isDarkMode ? CustomColors.darkCard : CustomColors.lightCard;
    final textColor =
        isDarkMode ? CustomColors.darkText : CustomColors.lightText;
    final secondaryTextColor =
        isDarkMode
            ? CustomColors.darkSecondaryText
            : CustomColors.lightSecondaryText;

    // Shadow color adjustment
    final shadowColor =
        isDarkMode
            ? Colors.black.withOpacity(0.8) // Darker shadow in dark mode
            : Colors.black.withOpacity(0.2); // Lighter shadow in light mode

    return GestureDetector(
      onTap: () async {
        // audioFile = audioAsync.value;

        ref.read(selectedSurahProvider.notifier).state =
            widget.item.values.first;
        ref.read(selectedReciterProvider.notifier).state =
            widget.item.keys.first;
        ref.read(compactAudioPlayerVisibilityProvider.notifier).state = true;

        try {
          final audioFile = await ref.read(
            audioFileProvider((
              widget.item.keys.first.id,
              widget.item.values.first.id,
            )).future,
          );

          ref.read(audioServiceProvider.notifier).changeAudio(audioFile, ref);
        } catch (e) {}
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: _isHovered ? 15 : 8, // Increase blur on hover
                offset: Offset(
                  0,
                  _isHovered ? 10 : 4, // Increase offset on hover
                ),
                spreadRadius:
                    _isHovered ? 4 : 0, // Spread the shadow when hovered
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.values.first.nameArabic,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor, // البيج في الوضع الفاتح
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.item.keys.first.nameArabic,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: secondaryTextColor, // أصفر في الوضع الفاتح
                  ),
                  textAlign: TextAlign.center,
                ),
                // if (compactOn) const CompactAudioPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
