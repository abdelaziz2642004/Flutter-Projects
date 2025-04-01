import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';

class DetailsService {
  static const int maxlines = 2;
  String selectedSize = 'S';
  int selectedQuantity = 1;
  bool isFavorite = true;

  DetailsService({required this.rebuild});
  final void Function(VoidCallback) rebuild; // for the parent widget

  void toggleFavorite(WidgetRef ref, String cofeeId) async {
    user currentUser = ref.read(userProvider).value ?? user();
    final firestore = FirebaseFirestore.instance.collection('Users');

    isFavorite = !isFavorite;
    rebuild(() {}); // for the parent widget

    if (isFavorite) {
      currentUser.favorited.add(cofeeId);
      await firestore.doc(currentUser.id).update({
        'favorited': FieldValue.arrayUnion([cofeeId]),
      });
    } else {
      currentUser.favorited.remove(cofeeId);
      await firestore.doc(currentUser.id).update({
        'favorited': FieldValue.arrayRemove([cofeeId]),
      });
    }
  }

  void chooseSize(String newSize) {
    selectedSize = newSize;
    rebuild(() {}); // for the parent widget
  }

  void changeQuantity(int x) {
    selectedQuantity += x;
    if (selectedQuantity < 1) selectedQuantity = 1;
    rebuild(() {}); // for the parent widget
  }
}
