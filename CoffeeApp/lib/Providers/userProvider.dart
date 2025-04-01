import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/Notification.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Models/WishList.dart';
import 'package:prj/Models/WishlistItem.dart';
import 'package:prj/Providers/drinksProvider.dart';

final userProvider = FutureProvider<user>((ref) async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return user();
    }

    print("I got here 1");
    String userId = currentUser.uid;
    print(userId);

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    print("I got here 2");

    if (!userDoc.exists) {
      print("I got here 3");

      return user();
    }

    // Fetch all drinks from provider
    List<Coffee> allDrinks = ref.watch(drinksProvider).value ?? [];
    Map<String, Coffee> coffeeMap = {
      for (var coffee in allDrinks) coffee.id: coffee,
    };

    // Fetch Wishlist
    List<WishlistItem> wishlistItems = await fetchWishlist(userId, coffeeMap);
    double total = wishlistItems.fold(
      0,
      (sum, item) => sum + (item.coffee.getPrice(item.size) * item.quantity),
    );

    Wishlist myWishlist = Wishlist(items: wishlistItems, total: total);

    // Fetch Notifications
    List<myNotification> notifications = await fetchNotifications(
      userId,
      coffeeMap,
    );

    // Create and return User object
    return user(
      favorited: List<String>.from(
        userDoc['favorited'] ?? [],
      ), // ✅ FIX: Ensure favorited is a List<String>
      notifications: notifications,
      id: userId,
      email: userDoc['email'] ?? '',
      ImageUrl: userDoc['imageUrl'] ?? '',
      fullName: userDoc['fullname'] ?? '',
      wishlist: myWishlist,
    );
  } catch (e) {
    throw Exception("Error fetching user: $e");
  }
});

Future<List<WishlistItem>> fetchWishlist(
  String userId,
  Map<String, Coffee> coffeeMap,
) async {
  CollectionReference wishlistRef = FirebaseFirestore.instance
      .collection('Wishlists')
      .doc(userId)
      .collection('items');

  QuerySnapshot wishlistSnapshot = await wishlistRef.get();

  return wishlistSnapshot.docs.map((doc) {
    var data = doc.data() as Map<String, dynamic>;

    return WishlistItem(
      id: doc.id,
      coffee: coffeeMap[data['coffeeID']]!,
      quantity: data['quantity'] ?? 1,
      size: data['size'] ?? 'M',
      addedAt: (data['addedAt'] as Timestamp).toDate(),
    );
  }).toList();
}

Future<List<myNotification>> fetchNotifications(
  String userId,
  Map<String, Coffee> coffeeMap,
) async {
  CollectionReference notificationsRef = FirebaseFirestore.instance
      .collection('Notifications')
      .doc(userId)
      .collection('items');

  QuerySnapshot notificationsSnapshot = await notificationsRef.get();

  return notificationsSnapshot.docs.map((doc) {
    var data = doc.data() as Map<String, dynamic>;

    return myNotification(
      id: doc.id,
      message: data['message'] ?? '',
      c: coffeeMap[data['coffeeID']],
    );
  }).toList();
}
