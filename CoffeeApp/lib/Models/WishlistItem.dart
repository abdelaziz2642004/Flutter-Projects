import 'package:prj/Models/Coffee.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

class WishlistItem {
  final String id;
  // final String userId; // Since we will add the wishlist to the user model, we don't need to store the userId in the wishlist item.
  final Coffee coffee;
  int quantity;
  final DateTime addedAt;
  final String size;

  WishlistItem({
    String? id,
    required this.coffee,
    required this.addedAt,
    required this.quantity,
    required this.size,
  }) : id = id ?? uuid.v4();
}
