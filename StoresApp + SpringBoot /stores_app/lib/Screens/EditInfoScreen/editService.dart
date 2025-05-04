import 'dart:convert';

import 'package:store_app/FieldsData/Service.dart';
import 'package:store_app/FieldsData/SuccessMessage.dart';
import 'package:store_app/Providers/customerProvider.dart';
// import 'package:store_app/Providers/customerProviderr.dart';

import 'package:store_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class EditService extends Service {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  EditService({
    required this.rebuildParent,
    required this.ref,
  }); // Removed 'const'

  final WidgetRef ref;

  final Function rebuildParent;

  Future<bool> checkBackendConnection() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  Future<void> editStudent() async {
    final response = await http.post(
      Uri.parse("$baseUrl/editCustomer"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "id": ID,
        "name": fullName,
        "gender": gender,
        "level": level ?? 0,
      }),
    );

    if (response.statusCode == 200) {
      // print("Student edited successfully!");
      ref.read(customerProviderr.notifier).updateGender(gender);
      ref.read(customerProviderr.notifier).updateFullName(fullName);
      ref.read(customerProviderr.notifier).updateLevel(level);

      // pop up sucesful
    } else {
      // print("Failed to add student: ${response.body}"); // try again
    }
  }

  Future<bool> changePassword(BuildContext context) async {
    String newPassword = confirmPassword; // just for you to understand :D
    if (password == ref.read(customerProviderr).password) {
      final response = await http.post(
        Uri.parse("$baseUrl/changePassword"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": ID, "password": newPassword}),
      );

      if (response.statusCode == 200) {
        // print("Student edited successfully!");
        ref.read(customerProviderr.notifier).updatePassword(newPassword);
        // showSuccessPopup(context, "🎉 Success!");
        return true;
        // pop up sucesful
      } else {
        // print("Failed to add student: ${response.body}"); // try again
        showSuccessPopup(context, " ❌ Something went wrong! try again");
        return false;
      }
    }
    return false;
  }

  Future<void> deleteAccount(BuildContext context) async {
    final response = await http.post(
      Uri.parse("$baseUrl/deleteCustomer"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"id": ID}),
    );

    if (response.statusCode == 200) {
      // print("Student deleted successfully!");
      showSuccessPopup(context, " ✅. done deleted");
      // pop up sucesful
    } else {
      // print("Failed to add student: ${response.body}"); // try again
      showSuccessPopup(
        context,
        " ❌ Something went wrong! try again some other time",
      );
    }
  }
}
