import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';

class favItemStyle extends ConsumerWidget {
  const favItemStyle({
    super.key,
    required this.coffee,
    required this.onToggleFavorite,
  });

  final Coffee coffee;
  final Function(String) onToggleFavorite;

  static const Color favoriteColor = Color(0xffc47c51);
  static const Color shadowColor = Color.fromARGB(255, 203, 203, 203);
  static const double borderRadius = 12;
  static const double imageSize = 100;
  static const double paddingSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user currentUser = ref.read(userProvider).value ?? user();

    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(paddingSize),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(color: shadowColor, blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: coffee.imageUrl,
              height: imageSize,
              width: imageSize,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'DopisBold',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  coffee.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              currentUser.favorited.contains(coffee.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favoriteColor,
            ),
            onPressed: () => onToggleFavorite(coffee.id),
          ),
        ],
      ),
    );
  }
}
