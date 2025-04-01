import 'package:Aklatoo/Provider/category_provider.dart';
import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/mealdetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:transparent_image/transparent_image.dart';

class MealItemTop extends ConsumerStatefulWidget {
  const MealItemTop({super.key, required this.meal, required this.highlight});
  final Meal meal;
  final String highlight;

  @override
  ConsumerState<MealItemTop> createState() => _MealItemState();
}

class _MealItemState extends ConsumerState<MealItemTop> {
  void _selectMeal(BuildContext ctx, Meal meal) async {
    await Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => MealDetails(meal: meal),
      ),
    );
    // setState(() {});
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

  // Function to create highlighted text
  TextSpan _highlightSubstring(String text, String highlight) {
    final List<TextSpan> spans = [];
    final RegExp exp = RegExp(highlight, caseSensitive: false);
    int start = 0;

    for (final match in exp.allMatches(text)) {
      if (start < match.start) {
        spans.add(TextSpan(
            text: text.substring(start, match.start),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ))); // Default text color
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: const TextStyle(
          color: Colors.green,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ), // Highlight color
      ));
      start = match.end;
    }

    if (start < text.length) {
      spans.add(TextSpan(
          text: text.substring(start),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ))); // Default text color
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    // Access the dynamically updated categories map
    final categoriesNotifier = ref.watch(availableCategoriesProvider.notifier);
    final categoriesMap = categoriesNotifier.categoriesMap;

    // Replace category IDs with their corresponding titles
    final categoryTitles = widget.meal.categories
        .map((id) => categoriesMap[id] ?? 'Unknown')
        .join(', ');

    isSelected =
        ref.read(favoriteMealsProvider.notifier).isFavorite(widget.meal);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _selectMeal(context, widget.meal);
        },
        child: Stack(
          children: [
            // Image Container
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 220, // Adjusted the height to prevent layout break
                child: Hero(
                  tag: widget.meal.id,
                  child: Image(
                    image: CachedNetworkImageProvider(widget.meal.imageUrl),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            // Text and info part
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color:
                      Colors.black87, // Increased opacity for better contrast
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center text vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: _highlightSubstring(widget.meal.title,
                          widget.highlight), // Highlighted meal title
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: _highlightSubstring(categoryTitles,
                          widget.highlight), // Highlighted category titles
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            // Favorite icon
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 40.0, // Adjusted width
                height: 40.0, // Adjusted height
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
                    size: 26, // Slightly adjusted icon size
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
