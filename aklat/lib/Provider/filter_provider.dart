import 'package:Aklatoo/model/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Filterprv extends StateNotifier<Map<Filters, bool>> {
  // Constructor
  Filterprv() : super({}) {
    _loadFilters();
  }

  // Load filters from SharedPreferences
  Future<void> _loadFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final String? filtersJson = prefs.getString('filters');

    if (filtersJson != null) {
      // If filters exist in SharedPreferences, load them
      Map<String, dynamic> filtersMap = jsonDecode(filtersJson);
      state = {
        Filters.gluten: filtersMap[Filters.gluten.toString()] ?? false,
        Filters.lactose: filtersMap[Filters.lactose.toString()] ?? false,
        Filters.vegan: filtersMap[Filters.vegan.toString()] ?? false,
        Filters.vegetarian: filtersMap[Filters.vegetarian.toString()] ?? false,
      };
    } else {
      // Default filters
      state = {
        Filters.gluten: false,
        Filters.lactose: false,
        Filters.vegan: false,
        Filters.vegetarian: false,
      };
    }
  }

  // Set filters based on chosen filters
  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
    _saveFilters(); // Save to SharedPreferences
  }

  // Set individual filter
  void setFilter(Filters filter, bool value) {
    state = {...state, filter: value};
    _saveFilters(); // Save to SharedPreferences
  }

  // Empty filters
  void empty() {
    state = {
      Filters.gluten: false,
      Filters.lactose: false,
      Filters.vegan: false,
      Filters.vegetarian: false,
    };
    _saveFilters(); // Save to SharedPreferences
  }

  // Save filters to SharedPreferences
  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final filtersMap = {
      Filters.gluten.toString(): state[Filters.gluten],
      Filters.lactose.toString(): state[Filters.lactose],
      Filters.vegan.toString(): state[Filters.vegan],
      Filters.vegetarian.toString(): state[Filters.vegetarian],
    };
    await prefs.setString('filters', jsonEncode(filtersMap)); // Save as JSON
  }
}

// Provider declaration
final filterProvider = StateNotifierProvider<Filterprv, Map<Filters, bool>>(
  (ref) => Filterprv(),
);
