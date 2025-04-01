import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/mealdetails.dart';
import 'package:Aklatoo/widgets/meal_item_trait.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends ConsumerStatefulWidget {
  const MealItem({
    super.key,
    required this.meal,
  });
  final Meal meal;

  @override
  ConsumerState<MealItem> createState() => _MealItemState();
}

class _MealItemState extends ConsumerState<MealItem> {
  void _selectMeal(BuildContext ctx, Meal meal) async {
    await Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => MealDetails(meal: meal),
      ),
    );
    setState(() {});
  }

  bool isSelected = false;

  void _showInfoMessage(String message, Icon star) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            star, // Replace with your desired icon
            const SizedBox(width: 8), // Adds space between icon and text
            Expanded(child: Text(message)),
          ],
        ),
        behavior: SnackBarBehavior.floating, // Makes the SnackBar float
        padding: const EdgeInsets.all(15),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.07,
          left: 40.0, // Increased left margin for more space
          right: 40.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Rounded corners for the SnackBar
        ),
        duration:
            const Duration(seconds: 3), // Duration for the SnackBar visibility
      ),
    );
  }

  void toggleFavoriteStatus() {
    setState(() {
      bool wasAdded = ref
          .read(favoriteMealsProvider.notifier)
          .toggleFavoriteStatus(widget.meal);
      isSelected = !isSelected;
      final isdark = ref.read(themeProvider);

      if (wasAdded) {
        widget.meal.total++;
        _showInfoMessage("Marked as a favorite!",
            const Icon(Icons.star, color: Color.fromARGB(255, 255, 107, 1)));
      } else {
        widget.meal.total--;

        _showInfoMessage(
            "Meal is no longer a favorite.",
            Icon(
              Icons.star_border,
              color: isdark == ThemeMode.dark ? Colors.black : Colors.white,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isSelected =
        ref.read(favoriteMealsProvider.notifier).isFavorite(widget.meal);

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          _selectMeal(context, widget.meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: widget.meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: CachedNetworkImageProvider(widget.meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                fadeInDuration: const Duration(milliseconds: 250),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      widget.meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${widget.meal.duration} mins',
                          color: const Color.fromARGB(255, 231, 229, 229),
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: widget.meal.complexity.name,
                          color: const Color.fromARGB(255, 231, 229, 229),
                        ),
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: widget.meal.affordability.name,
                          color: const Color.fromARGB(255, 231, 229, 229),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(138, 255, 255, 255),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  onPressed: toggleFavoriteStatus,
                  icon: Icon(
                    isSelected ? Icons.star : Icons.star_border,
                    color: isSelected
                        ? const Color.fromARGB(255, 255, 107, 1)
                        : const Color.fromARGB(255, 2, 2, 1),
                    size: 29,
                  ),
                  // iconSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
