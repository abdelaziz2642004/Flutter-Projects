import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/categoriesProvider.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/CustomAppBar.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/addToCart/addToCart.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/cofeeImage.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/coffeeDescription.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/coffeeInfo.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/coffeeQuantitySelector.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/coffeeSizeSelector.dart';
import 'package:prj/Screens/DetailsScreen.dart/DetailsService.dart';

class CoffeeDetailsScreen extends ConsumerStatefulWidget {
  const CoffeeDetailsScreen({super.key, required this.coffee});
  final Coffee coffee;
  @override
  ConsumerState<CoffeeDetailsScreen> createState() =>
      _CoffeeDetailsScreenState();
}

class _CoffeeDetailsScreenState extends ConsumerState<CoffeeDetailsScreen> {
  late final DetailsService detailsService;

  @override
  void initState() {
    super.initState();
    final user currentUser = ref.read(userProvider).value ?? user(); // Guest
    detailsService = DetailsService(rebuild: setState);
    detailsService.isFavorite = currentUser.favorited.contains(
      widget.coffee.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff9f9f9), // Added const
        appBar: customAppBar(
          isFavorite: detailsService.isFavorite,
          toggleFavorite: () {
            detailsService.toggleFavorite(ref, widget.coffee.id);
          },
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(25.0), // Already const
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.coffee,
                      child: CoffeeImage(imageUrl: widget.coffee.imageUrl),
                    ),
                    const SizedBox(height: 12), // Already const
                    ...CoffeeInfo(
                      widget.coffee,
                      ref.read(categoriesProvider).value ?? {},
                    ),
                    const SizedBox(height: 14),
                    ...CoffeeDescription(
                      description: widget.coffee.description,
                      maxlines: DetailsService.maxlines,
                    ),
                    const SizedBox(height: 14),
                    ...SizeSelector(
                      selectedSize: detailsService.selectedSize,
                      chooseSize: detailsService.chooseSize,
                    ),
                    const SizedBox(height: 14),
                    ...quantitySelector(
                      detailsService.selectedQuantity,
                      detailsService.changeQuantity,
                    ),
                  ],
                ),
              ),
            ),
            Addtocart(
              coffee: widget.coffee,
              size: detailsService.selectedSize,
              quantity: detailsService.selectedQuantity,
            ),
          ],
        ),
      ),
    );
  }
}
