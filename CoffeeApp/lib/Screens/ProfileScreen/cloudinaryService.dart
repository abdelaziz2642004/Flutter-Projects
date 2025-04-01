import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Providers/userProvider.dart';

class CloudinaryService {
  // I KNOW THIS IS REALLY BAD AND COMPLETELY UNSECURE , but i have no idea what to do
  // so I will definitely come back later to do this differently , just working on the functionality right now.
  static const String cloudName = "dv0opvwfu";
  static const String apiKey = "141946341514187";
  static const String apiSecret = "-LpCQkZjIOyOu2-cSQqE9Qe6HNE";
  static const String uploadPreset = "UsersPics";

  static Future<void> pickAndUploadImage(File pickedFile, WidgetRef ref) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;
    try {
      _deleteImage(currentUser.uid);
    } catch (e) {
      print("image didn't get deleted tho :D :(");
    }

    try {
      // Step 2: Upload new image
      String? imageUrl = await _uploadImage(pickedFile, currentUser.uid);
      if (imageUrl != null) {
        // Step 3: Update Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .update({'imageUrl': imageUrl});

        ref.invalidate(userProvider);
        // return imageUrl;

        // print("✅ Image uploaded and Firestore updated successfully!");
      } else {
        // print("❌ Image upload failed.");
      }
    } catch (e) {
      // print("❌ Error: $e");
    }
    // return '';
  }

  static Future<void> _deleteImage(String publicId) async {
    // Cloudinary cloudinary = Cloudinary.full(
    //   cloudName: cloudName,
    //   apiKey: apiKey,
    //   apiSecret: apiSecret,
    // );

    // try {
    //   await cloudinary.deleteResource(
    //     publicId: publicId,
    //     invalidate: true,
    //   ); // invalidate as true will delete also the cached version
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  static Future<String?> _uploadImage(File file, String publicId) async {
    Cloudinary cloudinary = Cloudinary.full(
      cloudName: cloudName,
      apiKey: apiKey,
      apiSecret: apiSecret,
    );
    CloudinaryUploadResource cloudinaryUploadResource =
        CloudinaryUploadResource(publicId: publicId, filePath: file.path);
    CloudinaryResponse cloudinaryResponse = await cloudinary.uploadResource(
      cloudinaryUploadResource,
    );

    return cloudinaryResponse.url;

    // final String apiUrl =
    //     "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    // var request =
    //     http.MultipartRequest('POST', Uri.parse(apiUrl))
    //       ..fields['upload_preset'] = uploadPreset
    //       ..fields['public_id'] = publicId
    //       ..files.add(
    //         await http.MultipartFile.fromPath(
    //           'file',
    //           file.path,
    //           contentType: MediaType.parse(
    //             lookupMimeType(file.path) ?? 'image/jpeg',
    //           ),
    //         ),
    //       );

    // var response = await request.send();
    // if (response.statusCode == 200) {
    //   final responseData = await http.Response.fromStream(response);
    //   return jsonDecode(responseData.body)['secure_url'];
    // } else {
    //   return null;
    // }
  }
}
