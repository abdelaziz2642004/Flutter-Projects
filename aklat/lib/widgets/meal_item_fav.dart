import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/mealdetails.dart';
import 'package:Aklatoo/widgets/meal_item_trait.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemfav extends ConsumerStatefulWidget {
  const MealItemfav({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  ConsumerState<MealItemfav> createState() => _MealItemState();
}

class _MealItemState extends ConsumerState<MealItemfav> {
  bool isSelected = false;

  void _selectMeal(BuildContext ctx, Meal meal) {
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => MealDetails(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    isSelected =
        ref.watch(favoriteMealsProvider.notifier).isFavorite(widget.meal);

    return Dismissible(
      key: ValueKey(widget.meal.id),
      background: _buildDismissibleBackground(isLeftAligned: true),
      secondaryBackground: _buildDismissibleBackground(isLeftAligned: false),
      onDismissed: (direction) {
        widget.meal.total--;
        ref.read(favoriteMealsProvider.notifier).deletee(widget.meal, context);
      },
      child: _buildMealCard(),
    );
  }

  Widget _buildDismissibleBackground({required bool isLeftAligned}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.deepOrange],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        alignment: isLeftAligned ? Alignment.centerLeft : Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment:
              isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            if (isLeftAligned)
              const Icon(Icons.delete_forever, color: Colors.white, size: 40),
            const SizedBox(width: 10),
            const Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isLeftAligned)
              const Icon(Icons.delete_forever, color: Colors.white, size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard() {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => _selectMeal(context, widget.meal),
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
                        ),
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
                  onPressed: () {
                    ref
                        .read(favoriteMealsProvider.notifier)
                        .deletee(widget.meal, context);
                  },
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
