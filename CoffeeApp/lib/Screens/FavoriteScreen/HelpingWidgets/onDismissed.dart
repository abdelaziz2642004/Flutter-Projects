import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';

import 'package:prj/Screens/DetailsScreen.dart/Details.dart';
import 'package:prj/Screens/FavoriteScreen/HelpingWidgets/FavoriteItem.dart';

class FavoriteItem extends ConsumerWidget {
  final Coffee coffee;
  final Function(String) onToggleFavorite;

  const FavoriteItem({
    super.key,
    required this.coffee,
    required this.onToggleFavorite,
  });

  static const Color deleteBgColor = Colors.redAccent;
  static const Color favoriteColor = Color(0xffc47c51);
  static const Color shadowColor = Color.fromARGB(255, 203, 203, 203);
  static const double borderRadius = 12;
  static const double imageSize = 100;
  static const double paddingSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(coffee.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onToggleFavorite(coffee.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: deleteBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CoffeeDetailsScreen(coffee: coffee),
            ),
          );
        },
        child: favItemStyle(coffee: coffee, onToggleFavorite: onToggleFavorite),
      ),
    );
  }
}
