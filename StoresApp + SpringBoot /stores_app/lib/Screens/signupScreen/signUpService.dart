import 'package:store_app/FieldsData/Service.dart';
import 'package:store_app/FieldsData/SuccessMessage.dart';
import 'package:store_app/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpService extends Service {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  // this code is completely unrelted to your local machine , this is another device !!
  Future<void> addStudent(BuildContext context) async {
    final response = await http.post(
      Uri.parse("$baseUrl/addCustomer"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": ID,
        "name": fullName,
        "gender": gender,
        "email": email,
        "level": level,
        "password": password,
        "imageData": null,
      }),
    );
    if (response.statusCode == 200) {
      // print("Student added successfully!");// pop up sucesful
      showSuccessPopup(context, "🎉 Success!");
      // Navigator.of(context).pop(); // Go back to login
    } else {
      if (context.mounted) {
        showSuccessPopup(context, " ❌ SignUp failed , Please Try again!");
      }
    }
  }

  Future<bool> IDexist(BuildContext context) async {
    final response = await http.post(
      Uri.parse("$baseUrl/IDexists"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": ID}),
    );

    if (response.statusCode == 200) {
      bool exists = jsonDecode(response.body) as bool;
      return exists;
    } else {
      if (context.mounted) {
        showSuccessPopup(context, " ❌ Request failed, Please Try again!");
      }
      return false;
    }
  }
}
