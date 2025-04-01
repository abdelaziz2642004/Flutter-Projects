import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prj/Models/User.dart';
import 'package:prj/Providers/drinksProvider.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/FavoriteScreen/HelpingWidgets/onDismissed.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  static const String emptyMessage = "Start Favoriting Some Meals!";
  static const Color textColor = Color(0xff292929);
  static const double fontSize = 18;

  void toggleFavorite(String coffeeId) async {
    final currentUser = ref.read(userProvider).value ?? user();
    final firestore = FirebaseFirestore.instance.collection('Users');

    setState(() {
      if (currentUser.favorited.contains(coffeeId)) {
        currentUser.favorited.remove(coffeeId);
        firestore.doc(currentUser.id).update({
          'favorited': FieldValue.arrayRemove([coffeeId]),
        });
      } else {
        currentUser.favorited.add(coffeeId);
        firestore.doc(currentUser.id).update({
          'favorited': FieldValue.arrayUnion([coffeeId]),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final drinksAsync = ref.watch(drinksProvider);
    final currentUser = ref.read(userProvider).value ?? user();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: drinksAsync.when(
        data: (drinks) {
          final favoriteCoffees =
              drinks
                  .where((coffee) => currentUser.favorited.contains(coffee.id))
                  .toList();

          return favoriteCoffees.isEmpty
              ? const Center(
                child: Text(
                  emptyMessage,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'DopisBold',
                    color: textColor,
                  ),
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoriteCoffees.length,
                itemBuilder: (context, index) {
                  return FavoriteItem(
                    coffee: favoriteCoffees[index],
                    onToggleFavorite: toggleFavorite,
                  );
                },
              );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stack) => Center(
              child: Text(
                "Error: $error",
                style: const TextStyle(color: Colors.red),
              ),
            ),
      ),
    );
  }
}
