import 'dart:convert';
import 'dart:typed_data';

import 'package:store_app/Models/store.dart';
import 'package:http/http.dart' as http;
import 'package:store_app/main.dart';

class StoreService {
  static Future<List<Store>> fetchStores() async {
    final response = await http.get(Uri.parse('$baseUrl/getStores'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((storeData) {
        Uint8List? imageBytes = base64Decode(
          storeData['imageData'] == null
              ? ''
              : storeData['imageData']['imageData'] as String,
        );

        return Store(
          id: storeData['id'],
          name: storeData['name'],
          description: storeData['description'],
          rating: storeData['rating'].toDouble(),
          latitude: storeData['latitude'].toDouble(),
          longitude: storeData['longitude'].toDouble(),
          imageBytes: imageBytes,
        );
      }).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }
}
