import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Providers/categoriesProvider.dart';
import 'package:prj/Screens/SearchScreen/SearchLogic.dart';

class SearchItem extends ConsumerWidget {
  final Coffee coffee;
  final String searchQuery;
  final VoidCallback onTap;

  const SearchItem({super.key, 
    required this.coffee,
    required this.searchQuery,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Hero(
              tag: coffee,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  coffee.imageUrl,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
                child: Column(
                  children: [
                    highlightText(
                      coffee.name,
                      searchQuery,
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 4),
                    highlightText(
                      coffee.categoryIDs
                          .map((id) => ref.read(categoriesProvider).value![id]!)
                          .join(' / '),
                      searchQuery,
                      size: 14,
                      weight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
