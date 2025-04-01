import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Screens/DetailsScreen.dart/Details.dart';
import 'package:prj/Screens/HomeScreen/HelpingWIdgets(BottomPart)/CoffeeItem./HelpingWidgets/Rating.dart';
import 'package:prj/Screens/HomeScreen/HelpingWIdgets(BottomPart)/CoffeeItem./HelpingWidgets/description.dart';

class CoffeeItem extends ConsumerWidget {
  final Coffee coffee;

  const CoffeeItem({super.key, required this.coffee});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => CoffeeDetailsScreen(coffee: coffee),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 253, 253, 253),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Hero(
              tag: coffee,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: coffee.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(top: 8, right: 8, child: ratingWidget(coffee)),

            Positioned(
              bottom: 2,
              left: 2,
              child: descriptionWidget(coffee, ref),
            ),
          ],
        ),
      ),
    );
  }
}
