import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';

Widget highlightText(
  String text,
  String query, {
  double size = 14,
  FontWeight weight = FontWeight.normal,
}) {
  if (query.isEmpty) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: Colors.white, fontWeight: weight),
    );
  }

  List<TextSpan> spans = [];
  int start = 0;
  text = text.toLowerCase();
  query = query.toLowerCase();

  while (start < text.length) {
    int index = text.indexOf(
      query,
      start,
    ); // to return the index of the first match of the query
    if (index == -1) {
      spans.add(
        TextSpan(text: text.substring(start)),
      ); // no match found , break
      break;
    }
    if (index > start) {
      spans.add(
        TextSpan(text: text.substring(start, index)),
      ); // from start to index-1 , these are not heighlited
    }
    // in the index , till the size of the query , this will be highlited
    spans.add(
      TextSpan(
        text: text.substring(index, index + query.length).toUpperCase(),
        style: TextStyle(
          fontWeight: weight,
          color: Colors.green,
          fontSize: size,
        ),
      ),
    );
    start =
        index + query.length; // no start searching again for the first match :D
  }

  return RichText(
    // this is the widget
    text: TextSpan(
      // THIS merges all the spans
      style: TextStyle(color: Colors.white, fontSize: size, fontWeight: weight),
      children: spans,
    ),
  );
}

List<Coffee> filterCoffeeList(
  String query,
  List<Coffee> availableCoffees,
  Map<String, String> categoryMap,
) {
  if (query.isEmpty) {
    return List.from(availableCoffees);
  }

  return availableCoffees.where((coffee) {
    return coffee.name.toLowerCase().contains(query.toLowerCase()) ||
        coffee.categoryIDs.any(
          (category) => categoryMap[category]!.toLowerCase().contains(
            query.toLowerCase(),
          ),
        );
  }).toList();
}
