import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Models/WishlistItem.dart';
import 'package:prj/Providers/userProvider.dart';

void addToWishlist({
  required WidgetRef ref,
  required BuildContext context,
  required Coffee coffee,
  required String size,
  required int quantity,
}) {
  final user currentUser = ref.watch(userProvider).value ?? user();

  final int index = currentUser.wishlist.items.indexWhere(
    (item) => item.coffee.id == coffee.id && item.size == size,
  );

  if (index != -1) {
    final WishlistItem existingItem = currentUser.wishlist.items[index];
    existingItem.quantity += quantity;
    currentUser.wishlist.total += existingItem.coffee.getPrice(size) * quantity;
    currentUser.wishlist.updateWishListItem(existingItem);
  } else {
    currentUser.wishlist.addItem(
      WishlistItem(
        coffee: coffee,
        addedAt: DateTime.now(),
        quantity: quantity,
        size: size,
      ),
    );
  }

  Navigator.pop(context);
}
