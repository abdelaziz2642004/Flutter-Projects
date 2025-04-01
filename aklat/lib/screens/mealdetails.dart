import 'package:Aklatoo/Provider/category_provider.dart';
import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/widgets/meal_item_trait.dart';
import 'package:Aklatoo/widgets/out_of_5.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class MealDetails extends ConsumerStatefulWidget {
  const MealDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  ConsumerState<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends ConsumerState<MealDetails> {
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected =
        ref.read(favoriteMealsProvider.notifier).isFavorite(widget.meal);
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating, // Makes the SnackBar float
        // width: 1,
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
    final wasAdded = ref
        .read(favoriteMealsProvider.notifier)
        .toggleFavoriteStatus(widget.meal);

    setState(() {
      isSelected = !isSelected;
      if (!wasAdded) {
        widget.meal.total--;
      } else {
        widget.meal.total++;
      }
    });

    if (wasAdded) {
      _showInfoMessage("Marked as a favorite!");
    } else {
      _showInfoMessage("Meal is no longer a favorite.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSelected =
        ref.read(favoriteMealsProvider.notifier).isFavorite(widget.meal);
    final theme = ref.read(themeProvider);
    final categoriesMap =
        ref.read(availableCategoriesProvider.notifier).categoriesMap;

    final categoryTitles = widget.meal.categories
        .map((id) => categoriesMap[id] ?? 'Unknown')
        .join(', ');

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Hero(
              tag: widget.meal.id,
              child: CachedNetworkImage(
                imageUrl: widget.meal.imageUrl,
                height: MediaQuery.of(context).size.height * 0.38,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: theme == ThemeMode.dark
                ? Colors.black.withOpacity(0)
                : Colors.white.withOpacity(0),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.34,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: theme == ThemeMode.dark
                    ? const Color(0xFF1E1E1E)
                    : Colors.white,
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.meal.title,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 228, 113, 19),
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1.0, 0),
                                    blurRadius: 3.0,
                                    color: theme == ThemeMode.dark
                                        ? const Color.fromARGB(
                                            39, 255, 255, 255)
                                        : const Color.fromARGB(39, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: toggleFavoriteStatus,
                            icon: Icon(
                              isSelected ? Icons.star : Icons.star_border,
                              color: isSelected
                                  ? const Color.fromARGB(255, 255, 175, 1)
                                  : theme == ThemeMode.dark
                                      ? Colors.white
                                      : const Color.fromARGB(255, 2, 2, 1),
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16), // Increased space

                      // Styled categories section
                      Row(
                        children: [
                          Text(
                            'Categories:  ',
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.green),
                          ),
                          Text(categoryTitles,
                              style: GoogleFonts.allerta(
                                fontSize: 15,
                                // color: Theme.of(context).colorScheme.scrim,
                              )),
                        ],
                      ),
                      const SizedBox(height: 30), // Meal traits section

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MealItemTrait(
                            icon: Icons.schedule,
                            label: '${widget.meal.duration} mins',
                            color: theme == ThemeMode.dark
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF000000),
                          ),
                          MealItemTrait(
                            icon: Icons.work,
                            label: widget.meal.complexity.name,
                            color: theme == ThemeMode.dark
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF000000),
                          ),
                          MealItemTrait(
                            icon: Icons.attach_money,
                            label: widget.meal.affordability.name,
                            color: theme == ThemeMode.dark
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF000000),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      ExpansionTile(
                        title: Text(
                          'Ingredients',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children: widget.meal.ingredients
                            .asMap()
                            .entries
                            .map((entry) {
                          final ingredient = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 8,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    ingredient,
                                    style: GoogleFonts.lora(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      ExpansionTile(
                        title: Text(
                          'Steps',
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        children:
                            widget.meal.steps.asMap().entries.map((entry) {
                          final index = entry.key + 1;
                          final step = entry.value;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  child: Text(
                                    index.toString(),
                                    style: GoogleFonts.openSans(
                                      color: theme == ThemeMode.dark
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    step,
                                    style: GoogleFonts.lora(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StarRating(
                            favoritesCount: widget.meal.total,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(60, 255, 255, 255),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Color.fromARGB(255, 255, 255, 255)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
