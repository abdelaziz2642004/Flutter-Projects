import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<Map<String, String>>((ref) async {
  try {
    final firestore = FirebaseFirestore.instance.collection('Categories');
    final querySnapshot = await firestore.get();
    final Map<String, String> map = {};

    for (var doc in querySnapshot.docs) {
      map[doc['id']] = doc['name'];
    }

    return map;
  } catch (e) {
    print('Error fetching categories: $e');
    return {};
  }
});
