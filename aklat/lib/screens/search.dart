import 'package:Aklatoo/Provider/available_provider.dart';
import 'package:Aklatoo/Provider/category_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/widgets/meal_item_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<Meal> result = [];
  String highlight = "";

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (highlight == "") {
      // Add initial search animation with message
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200, // Control animation size to prevent overflow
            child:
                Lottie.asset('assets/search.json'), // Initial search animation
          ),
          const SizedBox(height: 20), // Add space between animation and text
          const Center(
            child: Text(
              "Start searching by Categories or Meal titles !!!",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    } else if (result.isEmpty) {
      content = Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "OOPS!! Couldn't find any meals",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 200, // Adjust the height for the "not found" animation
            child: Lottie.asset('assets/notfound.json'),
          ),
        ],
      ));
    } else {
      content = Expanded(
        child: ListView.builder(
          itemCount: result.length,
          itemBuilder: (ctx, index) =>
              MealItemSearch(meal: result[index], highlight: highlight),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                highlight = value.toLowerCase();
                List<Meal> sth = [];
                if (value != '') {
                  final meals = ref.read(availableMealsProvider);
                  final categoriesMap = ref
                      .read(availableCategoriesProvider.notifier)
                      .categoriesMap;

                  for (Meal v in meals) {
                    // Check if title contains the highlight string
                    if (v.title.toLowerCase().contains(highlight)) {
                      sth.add(v);
                    } else {
                      // Check categories, ensuring categoriesMap entry is not null
                      for (String cat in v.categories) {
                        final categoryName = categoriesMap[cat];
                        if (categoryName != null &&
                            categoryName.toLowerCase().contains(highlight)) {
                          sth.add(v);
                          break; // Break once a match is found in categories
                        }
                      }
                    }
                  }
                }

                // Update the result state
                setState(() {
                  result = sth;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              // Use Expanded to avoid overflow
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
