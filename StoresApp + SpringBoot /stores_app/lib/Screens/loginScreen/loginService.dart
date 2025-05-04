import 'dart:typed_data';
import 'package:store_app/FieldsData/Service.dart';
import 'package:store_app/FieldsData/SuccessMessage.dart';
import 'package:store_app/Models/Customer.dart';
import 'package:store_app/Providers/customerProvider.dart';
import 'package:store_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Loginservice extends Service {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;
  Loginservice({required this.ref});
  final WidgetRef ref;

  Future<bool> getCustomer(BuildContext context) async {
    final response = await http.post(
      Uri.parse("$baseUrl/getCustomer"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'id': ID, 'password': password.trim()}),
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      Map<String, dynamic> json = await jsonDecode(response.body);
      Uint8List? imageBytes = base64Decode(
        json['imageData'] == null
            ? ''
            : json['imageData']['imageData'] as String,
      );

      Customer customer = Customer(
        fullName: json['name'] as String,
        email: json['email'] as String,
        ID: json['id'] as int,
        password: json['password'] as String,
        gender: json['gender'],
        imageBytes: imageBytes,
      );

      ref.read(customerProviderr.notifier).updatecustomer(customer);

      // // Clear Hive storage and store new credentials
      // var box = Hive.box('credentials');
      // await box.clear();
      // await box.put('customerID', customer.customerID);
      // await box.put('password', customer.password);

      return true;
    } else {
      if (context.mounted) {
        showSuccessPopup(context, "❌ Wrong credentials ? try again");
      }
      return false;
    }
  }
}
