import 'package:store_app/Screens/signupScreen/signUpService.dart';
import 'package:store_app/Screens/signupScreen/signup_button_section.dart';
import 'package:store_app/Screens/signupScreen/signup_fields_section.dart';
import 'package:store_app/Screens/signupScreen/signup_header.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignUpService signUpService = SignUpService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SignupHeader(),
                  SignupFieldsSection(service: signUpService),
                  ...signupButtonSection(signUpService, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
