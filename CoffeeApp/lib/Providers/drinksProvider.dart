import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';

/*How FutureProvider Works:

1️⃣ When you first call ref.watch(futureProvider), it fetches the data once and caches it.
2️⃣ If you rebuild the widget that uses ref.watch(futureProvider), it does NOT refetch—it just reuses the cached data.
3️⃣ It only refetches if:

    You manually call ref.refresh(futureProvider).
    Its dependencies change (e.g., if the provider takes a parameter that changes).
    The app hot restarts (not just a hot reload).
    */

//:DDD

final drinksProvider = FutureProvider<List<Coffee>>((ref) async {
  try {
    final firestore = FirebaseFirestore.instance.collection('Drinks');
    final tmp = await firestore.get();
    List<Coffee> fetchedDrinks =
        tmp.docs.map((drinkDoc) {
          final drinkData = drinkDoc.data();

          return Coffee(
            id: drinkDoc.id, // Firestore document ID
            name: drinkData['name'] ?? '',
            description: drinkData['description'] ?? '',
            smallPrice: (drinkData['smallPrice'] ?? 0).toDouble(),
            mediumPrice: (drinkData['mediumPrice'] ?? 0).toDouble(),
            largePrice: (drinkData['largePrice'] ?? 0).toDouble(),
            imageUrl: drinkData['imageUrl'] ?? '',
            categoryIDs: List<String>.from(drinkData['categoryIDs'] ?? []),
            rating: (drinkData['rating'] ?? 0).toDouble(),
            ratingCount: drinkData['ratingCount'] ?? 0,
            isSugary: drinkData['isSugary'] ?? true,
            isDairy: drinkData['isDairy'] ?? true,
            isDecaf: drinkData['isDecaf'] ?? false,
            containsNuts: drinkData['containsNuts'] ?? false,
            containsCaffeine: drinkData['containsCaffeine'] ?? true,
          );
        }).toList();

    return fetchedDrinks;
  } catch (e) {
    print('Error fetching drinks: $e');
    rethrow; // Ensure the error is passed to Riverpod
  }
});
