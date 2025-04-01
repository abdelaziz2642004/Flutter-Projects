import 'package:prj/Models/Coffee.dart';

class myNotification {
  final String message;
  Coffee coffee = Coffee(
    name: "null",
    description: "null",
    smallPrice: 0,
    mediumPrice: 0,
    largePrice: 0,
    imageUrl: "imageUrl",
    categoryIDs: [],
    rating: 0,
  );

  myNotification({required this.message, Coffee? c, String? id}) {
    if (c != null) {
      coffee = c;
    }
  }
}
