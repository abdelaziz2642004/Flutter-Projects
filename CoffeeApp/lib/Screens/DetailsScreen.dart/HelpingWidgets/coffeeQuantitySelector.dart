import 'package:flutter/material.dart';

List<Widget> quantitySelector(int quantity, void Function(int) changeQuantity) {
  return [
    const Text(
      "Quantity",
      style: TextStyle(
        color: Color(0xff292929),
        fontWeight: FontWeight.bold,
        fontFamily: 'DopisBold',
        fontSize: 20,
      ),
    ),
    const SizedBox(height: 10),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 30),
        IconButton(
          icon: const Icon(
            Icons.remove_circle,
            color: Color(0xffc47c51),
            size: 45,
          ),
          onPressed: () => changeQuantity(-1),
        ),
        const Spacer(),
        Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xffc47c51), width: 2),
          ),
          alignment: Alignment.center,
          child: Text(
            '$quantity',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
              color: Color(0xff292929),
              fontSize: 28,
            ),
          ),
        ),
        const Spacer(),

        IconButton(
          icon: const Icon(
            Icons.add_circle,
            color: Color(0xffc47c51),
            size: 45,
          ),
          onPressed: () => changeQuantity(1),
        ),
        const SizedBox(width: 30),
      ],
    ),
  ];
}
