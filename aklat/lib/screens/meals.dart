import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/widgets/meal_item.dart';
import 'package:Aklatoo/widgets/meal_item_fav.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package

class MealsScreen extends StatefulWidget {
  const MealsScreen(
      {super.key, this.title, required this.meals, required this.mode});
  final String mode;
  final String? title;
  final List<Meal> meals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/spider.json',
              width: 500, height: 300), // Lottie animation
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );

    if (widget.meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: widget.meals.length,
        itemBuilder: (ctx, index) => widget.mode == "fav"
            ? MealItemfav(
                meal: widget.meals[index],
              )
            : MealItem(meal: widget.meals[index]),
      );
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: content,
    );
  }
}
