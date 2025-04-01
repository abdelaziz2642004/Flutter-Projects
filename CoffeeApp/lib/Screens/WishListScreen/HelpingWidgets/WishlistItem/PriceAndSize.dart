import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/WishlistItem.dart';

Widget priceAndSize(Coffee coffee, WishlistItem item) {
  return Row(
    children: [
      Text(
        '\$${(coffee.getPrice(item.size) * item.quantity).toStringAsFixed(2)}  ',
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'DopisBold',
          color: Color.fromARGB(255, 144, 144, 144),
        ),
      ),
      const SizedBox(height: 4),

      Text(
        item.size == 'L'
            ? '-  Large '
            : item.size == 'M'
            ? '-  Medium'
            : '-  Small',
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'DopisBold',
          color: Color.fromARGB(255, 144, 144, 144),
        ),
      ),
    ],
  );
}
