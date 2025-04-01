import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Providers/availableDrinksProvider.dart';
import 'package:prj/Screens/HomeScreen/HelpingWIdgets(BottomPart)/CatList.dart';
import 'package:prj/Screens/HomeScreen/HelpingWIdgets(BottomPart)/GridView.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/OfferCard.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/filterMenu.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/searchBar.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/background_layout.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/locationDropDown.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/profileAvatar.dart';
import 'package:prj/Screens/SearchScreen/SearchScreen.dart';

const double kPadding = 22.0;
const double kSpacingSmall = 20.0;
const double kSpacingMedium = 30.0;
const String kAllCategories = 'all';
const String kLoadingAnimationPath = 'assets/JSON/loading.json';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});
  @override
  ConsumerState<Homescreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<Homescreen> {
  String cat = kAllCategories;
  List<Coffee> selectedCoffees = [];

  @override
  void initState() {
    super.initState();
    selectedCoffees = ref.read(availableDrinksProvider).value ?? [];
  }

  void rebuild(String newCatId) {
    final drinksAsync = ref.read(availableDrinksProvider);
    setState(() {
      cat = newCatId;
      selectedCoffees =
          (newCatId == kAllCategories)
              ? drinksAsync.value ?? []
              : drinksAsync.value
                      ?.where((coffee) => coffee.categoryIDs.contains(newCatId))
                      .toList() ??
                  [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final drinksAsync = ref.watch(availableDrinksProvider);
    if (cat == kAllCategories) selectedCoffees = drinksAsync.value ?? [];
    print(selectedCoffees);
    return Stack(
      children: [
        const BackgroundLayout(),
        Padding(
          padding: const EdgeInsets.all(kPadding),
          child: drinksAsync.when(
            data:
                (coffees) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [LocationDropdown(), Spacer(), ProfileAvatar()],
                    ),
                    const SizedBox(height: kSpacingSmall),
                    Hero(
                      tag: 'search',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Expanded(child: searchBar()),
                            FilterMenu(fromOut: true, filtering: (fil) {}),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: kSpacingMedium),
                    GestureDetector(onTap: () {}, child: const Offercard()),
                    const SizedBox(height: kSpacingSmall),
                    Catlist(selectedCatID: cat, rebuild: rebuild),
                    const SizedBox(height: kSpacingSmall),
                    Gridview(selectedCoffees: selectedCoffees),
                  ],
                ),
            loading: () => Center(child: Lottie.asset(kLoadingAnimationPath)),
            error: (error, stack) => Center(child: Text("Error: $error")),
          ),
        ),
      ],
    );
  }
}
