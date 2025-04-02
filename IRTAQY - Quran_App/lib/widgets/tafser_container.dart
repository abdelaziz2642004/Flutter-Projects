import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/widgets/colors.dart';
import '../core/widgets/theme_provider.dart';

class TafserContainer extends ConsumerWidget {
  final String text;

  const TafserContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final backgroundColor =
        !isDarkMode
            ? CustomColors.darkBackground
            : CustomColors.lightBackground;
    final appBarColor =
        isDarkMode ? CustomColors.darkAppBar : CustomColors.lightAppBar;
    final textColor =
        !isDarkMode ? CustomColors.darkText : CustomColors.lightText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: backgroundColor),
        textAlign: TextAlign.right,
      ),
    );
  }
}
