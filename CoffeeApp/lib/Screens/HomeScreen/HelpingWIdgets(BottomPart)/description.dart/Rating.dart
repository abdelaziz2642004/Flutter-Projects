import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';

Widget ratingWidget(Coffee coffee) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        const Icon(Icons.star, color: Colors.yellow, size: 16),
        const SizedBox(width: 4),
        Text(
          coffee.rating.toString(),
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
