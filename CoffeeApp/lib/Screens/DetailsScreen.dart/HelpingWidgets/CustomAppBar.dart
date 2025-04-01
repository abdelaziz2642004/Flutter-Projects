import 'package:flutter/material.dart';

AppBar customAppBar({
  required bool isFavorite,
  required VoidCallback toggleFavorite,
  required BuildContext context,
}) {
  return AppBar(
    title: const Text(
      "Detail",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'DopisBold',
        fontSize: 20,
      ),
    ),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      IconButton(
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        onPressed: toggleFavorite,
      ),
    ],
  );
}
