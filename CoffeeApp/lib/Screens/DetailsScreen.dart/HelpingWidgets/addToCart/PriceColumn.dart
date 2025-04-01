import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';

class priceColumn extends StatelessWidget {
  const priceColumn({super.key, required this.coffee, required this.size});

  final Coffee coffee;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Price",
          style: TextStyle(
            color: Color(0xff999999),
            fontWeight: FontWeight.normal,
            fontFamily: 'DopisBold',
            fontSize: 15,
          ),
        ),
        Text(
          '\$${coffee.getPrice(size)}',
          style: const TextStyle(
            color: Color(0xffc47c51),
            fontWeight: FontWeight.normal,
            fontFamily: 'DopisBold',
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
