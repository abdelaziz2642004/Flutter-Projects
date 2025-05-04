import 'dart:io';
import 'dart:typed_data';

import 'package:store_app/FieldsData/Service.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileService extends Service {
  ProfileService({required this.ref});

  final WidgetRef ref;

  static Future<bool> checkBackendConnection() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> uploadImage(File image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/$ID/addImage"),
      );

      String? mimeType = lookupMimeType(image.path);
      var mediaType =
          mimeType != null
              ? MediaType.parse(mimeType)
              : MediaType('application', 'octet-stream');

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          image.path,
          contentType: mediaType,
        ),
      );

      request.headers.addAll({"Content-Type": "multipart/form-data"});

      var response = await request.send();
      if (response.statusCode == 200) {
        print("Upload successful");
        Uint8List bytes = await image.readAsBytes();

        // ✅ Update studentProvider with the new image
        ref.read(customerProviderr.notifier).updateImage(bytes);
      } else {
        print("Failed to upload: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteImage() async {
    final response = await http.get(
      Uri.parse("$baseUrl/$ID/delImage"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      ref.read(customerProviderr.notifier).updateImage(Uint8List(0));
    }
  }
}
