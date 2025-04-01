// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/Provider/available_provider.dart';
// import 'package:meals/Provider/category_provider.dart';
// import 'package:meals/Provider/favorite_provider.dart';
// import 'package:meals/Provider/filter_provider.dart';
// import 'package:meals/Provider/meal_provider.dart';
// import 'package:meals/model/dummy_data.dart';
// import 'package:meals/model/meal.dart';
// import 'package:meals/model/category.dart';

// // import 'package:meals/model/category.dart';

// // // Now use this as a StateNotifierProvider
// // var availableMealsProvider =
// //     StateNotifierProvider<AvailableMealsNotifier, List<Meal>>((ref) {
// //   return AvailableMealsNotifier(ref);
// // });

// // var availableCategoriesProvider =
// //     StateNotifierProvider<AvailableCategoriesNotifier, List<Category>>((ref) {
// //   return AvailableCategoriesNotifier();
// // });

// // var favoriteMealsProvider = StateNotifierProvider<FavoriteProvider, List<Meal>>(
// //     (ref) => FavoriteProvider());

// // var filterProvider =
// //     StateNotifierProvider<Filterprv, Map<filters, bool>>((ref) => Filterprv());

// // var mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
// //   return MealsNotifier();
// // });

// // void run() {
// //   // order is important

// //   mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
// //     return MealsNotifier();
// //   });

// //   availableCategoriesProvider =
// //       StateNotifierProvider<AvailableCategoriesNotifier, List<Category>>((ref) {
// //     return AvailableCategoriesNotifier();
// //   });

// //   favoriteMealsProvider = StateNotifierProvider<FavoriteProvider, List<Meal>>(
// //       (ref) => FavoriteProvider());

// //   filterProvider = StateNotifierProvider<Filterprv, Map<filters, bool>>(
// //       (ref) => Filterprv());

// //   availableMealsProvider =
// //       StateNotifierProvider<AvailableMealsNotifier, List<Meal>>((ref) {
// //     return AvailableMealsNotifier(ref);
// //   });
// // }
