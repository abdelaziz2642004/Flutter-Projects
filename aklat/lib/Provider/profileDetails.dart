import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDetailsProvider extends StateNotifier<Map<String, dynamic>> {
  ProfileDetailsProvider() : super({}) {
    _initializeUserDetails();
  }

  Future<void> _initializeUserDetails() async {
    final _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(_currentUser.uid)
          .get();
      state = userDoc.data() ?? {}; // Ensure state is not null
    }
  }

  Future<void> updateProfilePicture(File? pickedImage) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // Create a reference to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('Users')
          .child('${currentUser.uid}.jpg'); // Assuming you want to save as .jpg

      // Upload the image
      if (pickedImage == null) {
        // erase the image at ref
        ref.delete();
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .update({
          'imageUrl': '',
        });
        return;
      }
      await ref.putFile(pickedImage);

      // Get the download URL
      final url = await ref.getDownloadURL();

      // Update Firestore with the new image URL
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.uid)
          .update({
        'imageUrl': url,
      });

      // Update the state with the new image URL
      state = {
        ...state,
        'imageUrl': url
      }; // Use the spread operator to maintain existing state
    }
  }

  void empty() {
    state = {};
    _initializeUserDetails();
  }

  void emptyonly() {
    state = {};
  }
}

// Now use this as a StateNotifierProvider
var profileDetailsProvider =
    StateNotifierProvider<ProfileDetailsProvider, Map<String, dynamic>>((ref) {
  return ProfileDetailsProvider();
});
