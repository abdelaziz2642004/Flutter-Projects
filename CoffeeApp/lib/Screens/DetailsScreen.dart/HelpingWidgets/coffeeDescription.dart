import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

List<Widget> CoffeeDescription({
  required String description,
  required int maxlines,
}) {
  return [
    const Text(
      "Description",
      style: TextStyle(
        color: Color(0xff292929),
        fontWeight: FontWeight.bold,
        fontFamily: 'DopisBold',
        fontSize: 18,
      ),
    ),
    const SizedBox(height: 5),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReadMoreText(
          description,
          trimLength: 120,
          colorClickableText: Colors.blue,
          trimMode: TrimMode.Length,
          trimCollapsedText: 'Read more',
          trimExpandedText: '  Read less',
          style: const TextStyle(
            color: Color.fromARGB(255, 147, 147, 147),
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
          ),
          moreStyle: const TextStyle(
            color: Color(0xffc47c51),
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
            fontSize: 15,
          ),
          lessStyle: const TextStyle(
            color: Color(0xffc47c51),
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
            fontSize: 15,
          ),
        ),
      ],
    ),
  ];
}
