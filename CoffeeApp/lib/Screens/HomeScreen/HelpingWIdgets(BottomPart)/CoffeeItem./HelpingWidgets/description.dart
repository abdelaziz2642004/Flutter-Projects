import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Models/WishlistItem.dart';
import 'package:prj/Providers/categoriesProvider.dart';
import 'package:prj/Providers/userProvider.dart';

Widget descriptionWidget(Coffee coffee, WidgetRef ref) {
  Map<String, String> categories = ref.read(categoriesProvider).value ?? {};
  user currentUser = ref.read(userProvider).value ?? user();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 150,
        height: 30,
        child: Text(
          coffee.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'DopisBold',
            fontSize: 18,
          ),
        ),
      ),
      if (categories.isNotEmpty)
        Text(
          categories[coffee.categoryIDs[0]] ?? 'Unknown Category',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xffb5b5b5),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),

      const SizedBox(height: 8),
      Row(
        children: [
          Text(
            "\$ ${coffee.getPrice('S')}",
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              fontFamily: 'AlongSanss',
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 50),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xffc47c51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                int index = currentUser.wishlist.items.indexWhere(
                  (item) => item.coffee.id == coffee.id && item.size == 'S',
                );

                if (index != -1) {
                  currentUser.wishlist.items[index].quantity++;
                  currentUser.wishlist.total += currentUser
                      .wishlist
                      .items[index]
                      .coffee
                      .getPrice('S');
                } else {
                  WishlistItem item = WishlistItem(
                    coffee: coffee,
                    addedAt: DateTime.now(),
                    quantity: 1,
                    size: 'S',
                  );
                  currentUser.wishlist.addItem(item);
                }
              },
              icon: const Icon(Icons.add),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    ],
  );
}
