import 'dart:async';

import 'package:Aklatoo/model/meal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteProvider extends StateNotifier<List<Meal>> {
  FavoriteProvider() : super([]) {
    _init();
  }
  Map<String, bool> map = {};

  Future<void> _init() async {
    final FirebaseFirestore fire = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final favoriteMealsSnapshot = await fire
          .collection('Users')
          .doc(user.uid)
          .collection('Favorite Meals')
          .get();

      final favoriteMeals = favoriteMealsSnapshot.docs.map((doc) {
        final data = doc.data();
        map[doc.id] = true;

        return Meal(
            id: doc.id,
            title: data['title'] ?? '',
            categories: List<String>.from(data['categories'] ?? []),
            duration: data['duration'] ?? 0,
            imageUrl: data['imageUrl'] ?? '',
            ingredients: List<String>.from(data['ingredients'] ?? []),
            steps: List<String>.from(data['steps'] ?? []),
            isGlutenFree: data['isGlutenFree'] ?? false,
            isVegan: data['isVegan'] ?? false,
            isVegetarian: data['isVegetarian'] ?? false,
            isLactoseFree: data['isLactoseFree'] ?? false,
            affordability: Affordability.values.firstWhere(
              (e) => e.name == data['affordability'],
            ),
            complexity: Complexity.values.firstWhere(
              (e) => e.name == data['complexity'],
            ),
            total: data['times'] ?? 0);
      }).toList();
      // print(
      // "here here herehere here here here here here here here here here here here here here here here here here ");
      // print(favoriteMeals.length);

      state = favoriteMeals;
    }
  }

  void empty() {
    state = [];
    map.clear();
    _init();
  }

  void emptyonly() {
    state = [];
    map.clear();
  }

  bool isFavorite(Meal meal) {
    return map[meal.id] ?? false;
  }

  bool toggleFavoriteStatus(Meal meal) {
    final isfavorite = isFavorite(meal);
    final FirebaseFirestore fire = FirebaseFirestore.instance;
    final User? user = FirebaseAuth.instance.currentUser;

    if (isfavorite) {
      state = state.where((element) => element.id != meal.id).toList();

      if (user != null) {
        final DocumentReference mealDocRef = fire
            .collection('Users')
            .doc(user.uid)
            .collection("Favorite Meals")
            .doc(meal.id);
        mealDocRef.delete();

// Update the 'times' field in the meal document by decrementing it by 1
        fire.collection('Meals').doc(meal.id).update({
          'times': FieldValue.increment(-1),
        });

        fire.collection('Meals').doc('total').update({
          'total': FieldValue.increment(-1),
        });
      }
      map[meal.id] = false;
      return false;
    } else {
      state = [...state, meal];
      map[meal.id] = true;

      fire.collection('Meals').doc(meal.id).update({
        'times': FieldValue.increment(1),
      });
      fire.collection('Meals').doc('total').update({
        'total': FieldValue.increment(1),
      });

      fire
          .collection('Users')
          .doc(user!.uid)
          .collection('Favorite Meals')
          .doc(meal.id)
          .set({
        'categories': meal.categories,
        'duration': meal.duration,
        'title': meal.title,
        'imageUrl': meal.imageUrl,
        'ingredients': meal.ingredients,
        'steps': meal.steps,
        'isGlutenFree': meal.isGlutenFree,
        'isVegan': meal.isVegan,
        'isVegetarian': meal.isVegetarian,
        'isLactoseFree': meal.isLactoseFree,
        'affordability': meal.affordability.name,
        'complexity': meal.complexity.name,
      });

      return true;
    }
  }

  void deletee(Meal sth, BuildContext context) async {
    // Cancel any previous SnackBar to avoid delays
    ScaffoldMessenger.of(context).clearSnackBars();
    toggleFavoriteStatus(sth);

    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Meal has been deleted. Would you like to undo?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // User cancels delete
              },
              child: const Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                toggleFavoriteStatus(sth); // Undo the deletion
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Undo'),
            ),
          ],
        );
      },
    );
  }
}

var favoriteMealsProvider = StateNotifierProvider<FavoriteProvider, List<Meal>>(
    (ref) => FavoriteProvider());
