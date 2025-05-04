import 'package:store_app/FieldsData/abstract_validate.dart';
import 'package:store_app/Screens/loginScreen/loginService.dart';
import 'package:store_app/login_and_signup_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFieldsSection extends StatefulWidget {
  const LoginFieldsSection({super.key, required this.loginservice});
  final Loginservice loginservice;

  @override
  State<LoginFieldsSection> createState() => _LoginFieldsSectionState();
}

class _LoginFieldsSectionState extends State<LoginFieldsSection> {
  late final List<Field> fields;

  @override
  void initState() {
    super.initState();
    fields = [
      StudentIDField(text: "Student ID", service: widget.loginservice),
      PasswordField(text: "Password", service: widget.loginservice),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          ...fields.map((element) {
            return Column(
              children: [
                LoginAndSignupField(field: element),
                const SizedBox(height: 20),
              ],
            );
          }),
        ],
      ),
    );
  }
}
