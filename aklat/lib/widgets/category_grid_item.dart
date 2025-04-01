import 'package:Aklatoo/model/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.cat,
    required this.ontap,
  });

  final void Function() ontap;
  final Category cat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16), // Set border radius here
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            16), // Ensure image also has the same border radius
        child: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fadeInDuration: const Duration(milliseconds: 250),
              image: CachedNetworkImageProvider(
                cat.url,
              ),
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Text(
                cat.title,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.2, // Adds some spacing between letters
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ], // Adds a shadow effect
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
