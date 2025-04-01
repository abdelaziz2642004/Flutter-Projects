import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoffeeImage extends StatelessWidget {
  final String imageUrl;

  const CoffeeImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 230,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget:
            (context, url, error) => const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            ),
      ),
    );
  }
}
