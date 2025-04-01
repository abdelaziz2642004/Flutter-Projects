import 'dart:async';
import 'package:Aklatoo/Provider/available_provider.dart';
import 'package:Aklatoo/Provider/category_provider.dart';
import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:Aklatoo/model/category.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/meals.dart';
import 'package:Aklatoo/widgets/category_grid_item.dart';
import 'package:Aklatoo/widgets/meal_item_Top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();

    _pageController = PageController(initialPage: _currentPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(availableMealsProvider.notifier).filterMeals();
      ref.read(profileDetailsProvider.notifier).empty();
    });

    // Set up Timer to auto-swipe the Top Picks every 3 seconds
// Set up Timer to auto-swipe the Top Picks every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          if (_currentPage < 4) {
            // Keep within the range of 5 items
            _currentPage = (_currentPage + 1) %
                min(ref.watch(availableMealsProvider).length,
                    5); // Use min to ensure limit to 5
          } else {
            _currentPage = 0;
          }
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer on dispose
    super.dispose();
  }

  void _selectCat(BuildContext ctx, Category cat) async {
    final filteredCat = ref
        .watch(availableMealsProvider)
        .where((meal) => meal.categories.contains(cat.id))
        .toList();

    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: cat.title,
          meals: filteredCat,
          mode: "notfav",
        ),
      ),
    );
  }

  Future<List<Meal>> _getTopPicks(WidgetRef ref) async {
    final availableMeals = ref.watch(availableMealsProvider);

    availableMeals.sort((a, b) => b.total.compareTo(a.total));

    List<Meal> topMeals = availableMeals.take(5).toList();

    return topMeals;
  }

  @override
  Widget build(BuildContext context) {
    final availableCategories = ref.watch(availableCategoriesProvider);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => SlideTransition(
        position: _animationController.drive(
          Tween(begin: const Offset(1, 0.3), end: const Offset(0, 0)).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Top Picks For YOU!',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Add Top Picks section
              FutureBuilder<List<Meal>>(
                future: _getTopPicks(ref),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching top picks'),
                    );
                  }

                  final topPicks = snapshot.data ?? [];

                  return Column(
                    children: [
                      if (topPicks.isNotEmpty)
                        SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemCount: min(topPicks.length, 5),
                            itemBuilder: (context, index) {
                              final meal = topPicks[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SizedBox(
                                  width: 0,
                                  child: MealItemTop(
                                    highlight: "",
                                    meal: meal,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 10),
                      // Page Indicator
                      if (topPicks.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(min(topPicks.length, 5), (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 12 : 6,
                              height: _currentPage == index ? 10 : 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            );
                          }),
                        )
                      else
                        Center(
                            child: SizedBox(
                                height: 200,
                                child: Lottie.asset('assets/notfound.json'))),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Categories',
                  style: GoogleFonts.beVietnamPro(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Use Expanded for the GridView
              Padding(
                padding: const EdgeInsets.all(24),
                child: GridView.builder(
                  shrinkWrap:
                      true, // Important for allowing the GridView to take only needed space
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevent grid from scrolling
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: availableCategories.length,
                  itemBuilder: (context, index) {
                    final category = availableCategories[index];
                    return CategoryGridItem(
                      cat: category,
                      ontap: () {
                        _selectCat(context, category);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
