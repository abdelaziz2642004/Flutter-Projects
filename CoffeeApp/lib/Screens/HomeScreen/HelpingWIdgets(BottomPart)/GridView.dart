import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Screens/HomeScreen/HelpingWIdgets(BottomPart)/CoffeeItem./CoffeeItem.dart';

class Gridview extends StatelessWidget {
  const Gridview({super.key, required this.selectedCoffees});

  final List<Coffee> selectedCoffees;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // How many elements next to each other in one row
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          childAspectRatio: 0.67,
        ),
        itemCount:
            selectedCoffees.length, // number of cards ( this will change )
        itemBuilder: (context, index) {
          return CoffeeItem(coffee: selectedCoffees[index]);
        },
      ),
    );
  }
}
