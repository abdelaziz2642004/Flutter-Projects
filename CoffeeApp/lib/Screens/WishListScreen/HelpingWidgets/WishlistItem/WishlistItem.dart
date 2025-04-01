import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Models/WishlistItem.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/WishlistItem/PriceAndSize.dart';
import 'package:prj/Screens/WishListScreen/HelpingWidgets/WishlistItem/QuantityPart.dart';

// did
class CartItemCard extends ConsumerWidget {
  const CartItemCard({required this.item, super.key, required this.rebuild});
  final WishlistItem item;
  final void Function() rebuild;

  void changeQuantity(int x, WidgetRef ref) {
    item.quantity += x;
    if (item.quantity <= 0) {
      removeItem(ref);
      return;
    } else {
      user currentUser = ref.read(userProvider).value ?? user();
      currentUser.wishlist.total += x * item.coffee.getPrice(item.size);
      currentUser.wishlist.updateWishListItem(item);
    }
    rebuild();
  }

  void removeItem(WidgetRef ref) {
    // currentUser.wishlist.total -=
    //     item.quantity * item.coffee.getPrice(item.size); // OMG IM SO DUMB WHY DO I MULTIPLY BY 0

    user currentUser = ref.read(userProvider).value ?? user();
    int quantity = item.quantity;
    if (quantity == 0) quantity = 1;

    currentUser.wishlist.total -= item.coffee.getPrice(item.size) * quantity;
    currentUser.wishlist.items.remove(item);

    currentUser.wishlist.removeItem(item);

    rebuild();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Coffee coffee = item.coffee;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 236, 236),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: coffee.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  coffee.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'DopisBold',
                  ),
                ),
                priceAndSize(coffee, item),
                quantityPart(
                  item: item,
                  changeQuantity: changeQuantity,
                  removeItem: removeItem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
