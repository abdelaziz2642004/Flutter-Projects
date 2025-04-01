// Computed Provider for filtering drinks

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Providers/drinksProvider.dart';
import 'package:prj/Providers/filtersProvider.dart';

// FutureProvider for filtering available drinks
final availableDrinksProvider = FutureProvider<List<Coffee>>((ref) async {
  final allDrinks = await ref.watch(drinksProvider.future);
  final Filters = ref.watch(filterProvider);

  // if false , and true , don't take it

  return allDrinks.where((drink) {
    if (!Filters[filters.containsCaffeine]! && drink.containsCaffeine) {
      return false;
    }
    if (!Filters[filters.containsNuts]! && drink.containsNuts) {
      return false;
    }
    if (!Filters[filters.isDairy]! && drink.isDairy) {
      return false;
    }
    if (!Filters[filters.isDecaf]! && drink.isDecaf) {
      return false;
    }
    if (!Filters[filters.isSugary]! && drink.isSugary) {
      return false;
    }
    return true;
  }).toList();
});
