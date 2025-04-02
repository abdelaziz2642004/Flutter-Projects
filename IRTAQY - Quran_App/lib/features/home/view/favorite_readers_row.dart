import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/colors.dart';
import 'package:quran_app/core/widgets/theme_provider.dart';
import 'package:quran_app/features/home/view/ReciterItem_home.dart';
import 'package:quran_app/features/home/view_model/home_view_model.dart';

class FavoriteReadersRow extends ConsumerWidget {
  const FavoriteReadersRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final textColor =
        isDarkMode ? CustomColors.darkText : CustomColors.lightText;

    return SizedBox(
      height: 100,
      child: Consumer(
        builder: (context, ref, child) {
          final favoriteReciters = ref.watch(favoriteRecitersProvider);
          if (favoriteReciters.isEmpty) {
            return Center(
              child: Text(
                'No favorite reciters',
                style: TextStyle(
                  color:
                      isDarkMode
                          ? CustomColors.darkSecondaryText
                          : CustomColors.lightSecondaryText,
                ),
              ),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: ref.watch(favoriteRecitersProvider).length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ReciterItem(
                    reciter: ref.watch(favoriteRecitersProvider)[index],
                    textColor: textColor,
                    isDarkMode: isDarkMode, // Pass dark mode flag
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
