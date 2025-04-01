import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Filterprv extends StateNotifier<Map<filters, bool>> {
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
        filters.containsCaffeine:
            filtersMap[filters.containsCaffeine.toString()] ?? true,
        filters.containsNuts:
            filtersMap[filters.containsNuts.toString()] ?? true,
        filters.isDairy: filtersMap[filters.isDairy.toString()] ?? true,
        filters.isDecaf: filtersMap[filters.isDecaf.toString()] ?? true,
        filters.isSugary: filtersMap[filters.isSugary.toString()] ?? true,
      };
    } else {
      // Default filters
      state = {
        filters.containsCaffeine: true,
        filters.containsNuts: true,
        filters.isDairy: true,
        filters.isDecaf: true,
        filters.isSugary: true,
      };
    }
  }

  // Set filters based on chosen filters
  void setFilters(Map<filters, bool> chosenFilters) {
    state = chosenFilters;
    _saveFilters(); // Save to SharedPreferences
  }

  // Set individual filter
  void setFilter(filters filter, bool value) {
    state = {...state, filter: value};
    _saveFilters(); // Save to SharedPreferences
  }

  // Empty filters
  void empty() {
    state = {
      filters.containsCaffeine: true,
      filters.containsNuts: true,
      filters.isDairy: true,
      filters.isDecaf: true,
      filters.isSugary: true,
    };
    _saveFilters(); // Save to SharedPreferences
  }

  // Save filters to SharedPreferences
  Future<void> _saveFilters() async {
    final prefs = await SharedPreferences.getInstance();
    final filtersMap = {
      filters.containsCaffeine.toString(): state[filters.containsCaffeine],
      filters.containsNuts.toString(): state[filters.containsNuts],
      filters.isDairy.toString(): state[filters.isDairy],
      filters.isDecaf.toString(): state[filters.isDecaf],
      filters.isSugary.toString(): state[filters.isSugary],
    };
    await prefs.setString('filters', jsonEncode(filtersMap)); // Save as JSON
  }
}

// Provider declaration
final filterProvider = StateNotifierProvider<Filterprv, Map<filters, bool>>(
  (ref) => Filterprv(),
);
