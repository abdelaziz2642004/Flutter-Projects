import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/custom_list_tile.dart';
import 'package:quran_app/features/downloads/view/downloads_surah_screen.dart';

import '../../../core/Models/Reciter.dart';
import '../../../core/Models/Surah.dart';
import '../../../core/services/ApiService.dart';
import '../../../core/view_models/download_manager.dart';
import '../../../core/widgets/colors.dart';
import '../../../core/widgets/theme_provider.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  Future<List<Surah>> fetchAndMatchSurahs(List<int> surahIds) async {
    try {
      List<Surah> networkSurahs = await QuranApiService.fetchSurahs();

      // Filter the surahs where ID matches
      List<Surah> matchedSurahs =
          networkSurahs.where((surah) => surahIds.contains(surah.id)).toList();

      return matchedSurahs;
    } catch (e) {
      debugPrint("Error fetching surahs: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadManager = context.watch<DownloadManager>();
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color:
          isDarkMode
              ? CustomColors.darkBackground
              : CustomColors.lightBackground,
      child: ListView.builder(
        itemCount: downloadManager.getDownloads().keys.toList().length,
        itemBuilder: (context, index) {
          final reciterIds = downloadManager.getDownloads().keys.toList();
          final reciterSurahs = downloadManager.getDownloads().values.toList();

          // Find the reciter safely
          final reciter = reciters[reciterIds[index]];
          if (reciter == null) return const SizedBox.shrink();
          return CustomListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                reciter.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
            title: reciter.nameEnglish.trim(),
            subtitle: reciter.nameArabic.trim(),
            trailing: const Icon(CupertinoIcons.chevron_forward),
            onTap: () async {
              List<Surah> surahs = await fetchAndMatchSurahs(
                reciterSurahs[index],
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => DownloadsSurahScreen(
                        reciter: reciter,
                        surahs: surahs,
                        downloadManager: downloadManager,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
