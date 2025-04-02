import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/colors.dart';
import 'package:quran_app/core/widgets/theme_provider.dart';
import 'package:quran_app/features/audio_playback/view/compact_player.dart';
import 'package:quran_app/features/audio_playback/view_model/CompactVisibilityProvider.dart';
import 'package:quran_app/features/home/view/FavoriteReadersTitle.dart';
import 'package:quran_app/features/home/view/RecentlyPlayedItemState.dart';
import 'package:quran_app/features/home/view/favorite_readers_row.dart'; // ✅ استدعاء الملف الجديد
import 'package:quran_app/features/home/view_model/home_view_model.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key, required this.func});

  final void Function() func;

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), (() {
      ref.read(favoriteRecitersProvider.notifier).load();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final compactOn = ref.watch(compactAudioPlayerVisibilityProvider);
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final backgroundColor =
        isDarkMode ? CustomColors.darkBackground : CustomColors.lightBackground;
    final textColor =
        isDarkMode ? CustomColors.darkText : CustomColors.lightText;
    final recentlyPlayed = ref.watch(homeViewModelProvider);
    ref.read(homeViewModelProvider.notifier).load();
    // ref.read(favoriteRecitersProvider.notifier).load();
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const FavoriteReadersTitle(),

            const FavoriteReadersRow(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recently Played',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ),

            Expanded(
              child:
                  ref.watch(homeViewModelProvider).isEmpty
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'No recently played items',
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    isDarkMode
                                        ? CustomColors.darkSecondaryText
                                        : CustomColors.lightSecondaryText,
                              ),
                            ),
                            TextButton(
                              onPressed: widget.func,
                              style: TextButton.styleFrom().copyWith(
                                overlayColor: WidgetStateProperty.resolveWith<
                                  Color?
                                >((Set<WidgetState> states) {
                                  if (states.contains(WidgetState.pressed)) {
                                    return isDarkMode
                                        ? CustomColors.darkText.withAlpha(33)
                                        : CustomColors.lightCard.withAlpha(
                                          33,
                                        ); // Color when pressed
                                  }
                                  if (states.contains(WidgetState.hovered)) {
                                    return isDarkMode
                                        ? CustomColors.darkText.withAlpha(10)
                                        : CustomColors.lightCard.withAlpha(
                                          10,
                                        ); // Color when hovered
                                  }
                                  return null; // Default (no overlay)
                                }),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Start listening now',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          isDarkMode
                                              ? CustomColors.darkText
                                              : CustomColors.lightCard,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 15,
                                    color:
                                        isDarkMode
                                            ? CustomColors.darkText
                                            : CustomColors.lightCard,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.0,
                              ),
                          itemCount: recentlyPlayed.length,
                          itemBuilder: (context, index) {
                            return RecentlyPlayedItem(
                              item: recentlyPlayed[index],
                            );
                          },
                        ),
                      ),
            ),
            if (compactOn) const CompactAudioPlayer(),
          ],
        ),
      ),
    );
  }
}
