// import 'package:Aklatoo/model/meal.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class MealsNotifier extends StateNotifier<List<Meal>> {
//   MealsNotifier(this.ref) : super([]) {
//     fetchMeals();
//   }

//   final Ref ref;

//   Future<void> fetchMeals() async {
//     try {
//       final firestore = FirebaseFirestore.instance.collection('Meals');
//       final mealsSnapshot = await firestore.get();
//       List<Meal> fetchedMeals = []; // Use a temporary list to gather meals

//       for (var mealDoc in mealsSnapshot.docs) {
//         final mealData = mealDoc.data();
//         final item = Meal(
//           id: mealDoc.id,
//           categories: List<String>.from(mealData['categories'] ?? []),
//           title: mealData['title'] ?? "",
//           imageUrl: mealData['imageUrl'] ?? "",
//           ingredients: List<String>.from(mealData['ingredients'] ?? []),
//           steps: List<String>.from(mealData['steps'] ?? []),
//           duration: mealData['duration'] ?? 0,
//           complexity: Complexity.values.firstWhere(
//             (complexity) => complexity.name == (mealData['complexity'] ?? ""),
//             orElse: () => Complexity.simple, // Default value if not found
//           ),
//           affordability: Affordability.values.firstWhere(
//             (affordability) =>
//                 affordability.name == (mealData['affordability'] ?? ""),
//             orElse:
//                 () => Affordability.affordable, // Default value if not found
//           ),
//           isGlutenFree: mealData['isGlutenFree'] ?? false, // Default to false
//           isLactoseFree: mealData['isLactoseFree'] ?? false, // Default to false
//           isVegan: mealData['isVegan'] ?? false, // Default to false
//           isVegetarian: mealData['isVegetarian'] ?? false, // Default to false
//           total: mealData['times'] ?? 0,
//         );
//         fetchedMeals.add(item); // Add to temporary list
//       }

//       state = fetchedMeals; // Update state once after processing all meals
//     } catch (e) {
//       // Handle errors, e.g., log or notify
//       // print('Error fetching meals: $e');
//       // Optionally, set state to empty or keep the current state
//     }
//   }

//   void empty() {
//     state = [];
//     fetchMeals();
//   }
// }

// final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>((ref) {
//   return MealsNotifier(ref);
// });
