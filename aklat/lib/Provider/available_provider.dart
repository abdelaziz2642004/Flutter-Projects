import 'package:Aklatoo/Provider/filter_provider.dart';
import 'package:Aklatoo/Provider/meal_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableMealsNotifier extends StateNotifier<List<Meal>> {
  AvailableMealsNotifier(this.ref) : super([]) {
    filterMeals();
  }
  final Ref ref;

  Future<void> filterMeals() async {
    final meals = ref.watch(mealsProvider);
    final selectedFilters = ref.watch(filterProvider);

    state = meals.where((meal) {
      if (selectedFilters[Filters.gluten]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filters.lactose]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters[Filters.vegan]! && !meal.isVegan) return false;
      if (selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    // print("done providing available meals");

    // print(state);
  }

  void empty() {
    state = [];
    filterMeals();
  }
}

// // Now use this as a StateNotifierProvider
var availableMealsProvider =
    StateNotifierProvider<AvailableMealsNotifier, List<Meal>>((ref) {
  return AvailableMealsNotifier(ref);
});
