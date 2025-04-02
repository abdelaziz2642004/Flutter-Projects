import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Reciter.dart';

import '../../../core/widgets/custom_list_tile.dart';
import '../../home/view_model/home_view_model.dart';
import '../../surah_selection/view/surah_list_screen.dart';

class ReciterList extends ConsumerStatefulWidget {
  final List<Reciter> reciters;

  const ReciterList({required this.reciters, super.key});

  @override
  ConsumerState<ReciterList> createState() => _ReciterListState();
}

class _ReciterListState extends ConsumerState<ReciterList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.reciters.length,
      itemBuilder: (context, index) {
        final reciter = widget.reciters[index];
        final isFavorite = ref.watch(favoriteRecitersProvider);
        return CustomListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SurahListScreen(reciter: reciter),
              ),
            );
          },
          title: reciter.nameEnglish,
          subtitle: reciter.nameArabic,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,

            children: [
              GestureDetector(
                onTap: () {
                  ref
                      .read(favoriteRecitersProvider.notifier)
                      .toggleFavorite(reciter);
                },
                child: Consumer(
                  builder: (context, ref, child) {
                    final favoriteReciters = ref.watch(
                      favoriteRecitersProvider,
                    );
                    final isFavorite = favoriteReciters.contains(reciter);

                    return Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        );
      },
    );
  }
}
