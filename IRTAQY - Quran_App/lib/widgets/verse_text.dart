import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/quran.dart' as quran;

import '../core/widgets/colors.dart';
import '../core/widgets/theme_provider.dart';

class VerseText extends ConsumerWidget {
  final int surahNumber;
  final int verseNumber;

  const VerseText({
    super.key,
    required this.surahNumber,
    required this.verseNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final backgroundColor =
        !isDarkMode ? CustomColors.darkCard : CustomColors.lightCard;
    final appBarColor =
        isDarkMode ? CustomColors.darkAppBar : CustomColors.lightAppBar;
    final textColor =
        !isDarkMode ? CustomColors.darkText : CustomColors.lightText;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              quran.getVerse(surahNumber, verseNumber, verseEndSymbol: true),
              // Fetch the actual verse
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'me_quran',
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
