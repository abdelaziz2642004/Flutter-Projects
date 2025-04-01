import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Providers/categoriesProvider.dart';

class Catlist extends ConsumerWidget {
  const Catlist({
    super.key,
    required this.rebuild,
    required this.selectedCatID,
  });

  final void Function(String) rebuild;
  final String selectedCatID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesMap = ref.watch(categoriesProvider).value ?? {};
    final categories = categoriesMap.entries.toList(); // Convert Map to List

    // print('${cat.name} ${cat.id}');

    return SizedBox(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final categoryEntry = categories[index];
          final categoryId = categoryEntry.key;
          final categoryName = categoryEntry.value;
          final bool isSelected = selectedCatID == categoryId;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
                rebuild(categoryId);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xffc47c51) : Colors.white,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "DopisBold",
                      fontSize: 16,
                      color:
                          isSelected ? Colors.white : const Color(0xff3f3f3f),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
