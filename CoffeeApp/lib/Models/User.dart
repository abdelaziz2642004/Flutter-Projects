import 'package:prj/Models/Notification.dart';
import 'package:prj/Models/WishList.dart';

/*
Final Answer:
If you're using SQL, use a separate wishlist table linked to users.
If you're using NoSQL (Firebase :D), store the wishlist as a list inside the user document.
*/

class user {
  final String _id;
  final String _email;
  final String _userName;

  final String _ImageUrl;
  final String _fullName;
  final Wishlist _wishlist;
  final List<String> _favorited;
  final List<myNotification> _notifications;

  user({
    String? id,
    String? email,
    String? userName,

    Wishlist? wishlist,
    String? ImageUrl,
    String? fullName,
    List<String>? favorited,
    List<myNotification>? notifications,
  }) : _id = id ?? '',
       _email = email ?? 'Guest',
       _wishlist = wishlist ?? Wishlist(),
       _ImageUrl = ImageUrl ?? '',
       _fullName = fullName ?? 'Guest',
       _favorited = favorited ?? [],
       _notifications = notifications ?? [],
       _userName = userName ?? '';

  String get id => _id;
  String get email => _email;
  String get ImageUrl => _ImageUrl;
  String get fullName => _fullName;
  String get userName => _userName;

  Wishlist get wishlist => _wishlist;
  List<String> get favorited => _favorited;
  List<myNotification> get notifications => _notifications;
}
