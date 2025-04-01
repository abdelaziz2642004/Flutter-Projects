import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prj/Models/WishlistItem.dart';

class Wishlist {
  final List<WishlistItem> items;
  double total = 0.0;

  Wishlist({List<WishlistItem>? items, double? total})
    : items = items ?? [],
      total = total ?? 0.0;

  void addItem(WishlistItem item) async {
    total += item.coffee.getPrice(item.size) * item.quantity;
    items.add(item);

    await updateWishListItem(item);
  }

  Future<void> updateWishListItem(WishlistItem item) async {
    /*/if found , change quantity to new quantity
  // and total which is in the 'Wishlist/UserID ['total'] , change it minusing the old quantity * and getprice of size
  // and adding the new quantity * coffee.getPrice(size);
  // ( or obviously ) --> total+= Quantity difference * coffee.getPrice(size) // better 

  // if not found , create a new item with any id in the data base and add the coffee.id , total , all of that */
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      if (userId.isEmpty) throw Exception("No user logged in");

      DocumentReference userWishlistRef = FirebaseFirestore.instance
          .collection('Wishlists')
          .doc(userId);

      CollectionReference itemsRef = userWishlistRef.collection('items');

      QuerySnapshot existingItems =
          await itemsRef
              .where('coffeeID', isEqualTo: item.coffee.id)
              .where('size', isEqualTo: item.size)
              .get();

      double coffeePrice = item.coffee.getPrice(item.size);
      int quantityDifference = item.quantity;

      if (existingItems.docs.isNotEmpty) {
        DocumentSnapshot existingItem = existingItems.docs.first;
        int oldQuantity = existingItem['quantity'] ?? 0;
        quantityDifference = item.quantity - oldQuantity;

        await itemsRef.doc(existingItem.id).update({'quantity': item.quantity});
      } else {
        await itemsRef.add({
          'coffeeID': item.coffee.id,
          'quantity': item.quantity,
          'size': item.size,
          'addedAt': Timestamp.now(),
        });
      }

      DocumentSnapshot wishlistDoc = await userWishlistRef.get();
      double oldTotal =
          wishlistDoc.exists ? (wishlistDoc['total'] ?? 0.0) : 0.0;
      double newTotal = oldTotal + (quantityDifference * coffeePrice);

      await userWishlistRef.set({'total': newTotal}, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error adding wishlist item: $e");
    }
  }

  Future<void> removeItem(WishlistItem item) async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      if (userId.isEmpty) throw Exception("No user logged in");

      DocumentReference userWishlistRef = FirebaseFirestore.instance
          .collection('Wishlists')
          .doc(userId);

      CollectionReference itemsRef = userWishlistRef.collection('items');

      QuerySnapshot existingItems =
          await itemsRef
              .where('coffeeID', isEqualTo: item.coffee.id)
              .where('size', isEqualTo: item.size)
              .get();

      if (existingItems.docs.isEmpty) {
        throw Exception("Item not found in wishlist");
      }

      DocumentSnapshot existingItem = existingItems.docs.first;
      int quantity = existingItem['quantity'] ?? 0;

      double priceReduction = quantity * item.coffee.getPrice(item.size);

      await itemsRef.doc(existingItem.id).delete();

      DocumentSnapshot wishlistDoc = await userWishlistRef.get();
      double oldTotal =
          wishlistDoc.exists ? (wishlistDoc['total'] ?? 0.0) : 0.0;
      double newTotal = (oldTotal - priceReduction).clamp(0.0, double.infinity);

      await userWishlistRef.set({'total': newTotal}, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error removing wishlist item: $e");
    }
  }

  Future<void> EmptyBasket() async {
    try {
      String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
      if (userId.isEmpty) throw Exception("No user logged in");

      DocumentReference userWishlistRef = FirebaseFirestore.instance
          .collection('Wishlists')
          .doc(userId);

      CollectionReference itemsRef = userWishlistRef.collection('items');

      // Delete all items in the wishlist
      QuerySnapshot wishlistItems = await itemsRef.get();
      for (var doc in wishlistItems.docs) {
        await doc.reference.delete();
      }

      // Reset the total to 0
      await userWishlistRef.set({'total': 0.0}, SetOptions(merge: true));
    } catch (e) {
      throw Exception("Error emptying wishlist: $e");
    }
  }

  void Finish() {
    items.clear();
    total = 0.0;
    EmptyBasket();
  }
}
