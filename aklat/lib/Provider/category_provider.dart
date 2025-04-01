import 'package:Aklatoo/model/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableCategoriesNotifier extends StateNotifier<List<Category>> {
  // Map to store category IDs and titles
  Map<String, String> categoriesMap = {};

  AvailableCategoriesNotifier() : super([]) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final firestore = FirebaseFirestore.instance.collection('Categories');
    final querySnapshot = await firestore.get();

    List<Category> fetchedCategories = [];

    for (var categoryDoc in querySnapshot.docs) {
      final item = Category(
        id: categoryDoc.id,
        title: categoryDoc['title'],
        url: categoryDoc['url'],
      );
      fetchedCategories.add(item);

      // Dynamically add to the map as each category is fetched
      categoriesMap[categoryDoc.id] = categoryDoc['title'];
    }

    state = fetchedCategories;
  }

  // Method to return the map (optional, for external use)
  Map<String, String> getCategoriesMap() {
    return categoriesMap;
  }

  void empty() {
    state = [];
    categoriesMap = {}; // Clear the map as well
    fetchCategories();
  }
}

var availableCategoriesProvider =
    StateNotifierProvider<AvailableCategoriesNotifier, List<Category>>((ref) {
  return AvailableCategoriesNotifier();
});
