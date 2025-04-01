import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/addToCart/PriceColumn.dart';
import 'package:prj/Screens/DetailsScreen.dart/HelpingWidgets/addToCart/addItemService.dart';

class Addtocart extends ConsumerWidget {
  const Addtocart({
    super.key,
    required this.coffee,
    required this.size,
    required this.quantity,
  });

  final Coffee coffee;
  final String size;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );

    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        height: 120,
        width: double.infinity,
        color: const Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              priceColumn(coffee: coffee, size: size),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  addToWishlist(
                    ref: ref,
                    context: context,
                    coffee: coffee,
                    size: size,
                    quantity: quantity,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 73,
                    vertical: 17,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  backgroundColor: const Color(0xffc47c51),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Color.fromARGB(255, 253, 253, 253),
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DopisBold',
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
