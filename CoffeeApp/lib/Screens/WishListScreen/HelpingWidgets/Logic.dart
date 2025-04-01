import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Models/WishlistItem.dart';
import 'package:prj/Providers/userProvider.dart';

class WishlistLogic {
  List<WishlistItem> wishlist = [];
  WidgetRef ref;
  WishlistLogic({required this.ref});

  void loadWishlist() {
    user currentUser = ref.read(userProvider).value ?? user();
    wishlist = currentUser.wishlist.items;
  }

  void checkout() {
    user currentUser = ref.read(userProvider).value ?? user();
    currentUser.wishlist.Finish();
    wishlist = [];
  }

  void removeItem(int index) {
    user currentUser = ref.read(userProvider).value ?? user();
    currentUser.wishlist.removeItem(wishlist[index]);
    wishlist.removeAt(index);
  }
}
