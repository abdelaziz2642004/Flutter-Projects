import 'package:flutter/material.dart';
import 'package:store_app/FieldsData/abstract_validate.dart';
import 'package:store_app/Screens/signupScreen/signUpService.dart';
import '../../login_and_signup_field.dart';

class SignupFieldsSection extends StatefulWidget {
  const SignupFieldsSection({super.key, required this.service});
  final SignUpService service;

  @override
  State<SignupFieldsSection> createState() => _SignupFieldsSectionState();
}

class _SignupFieldsSectionState extends State<SignupFieldsSection> {
  late final List<Field> fields;
  String? selectedGender;
  int? selectedLevel;

  @override
  void initState() {
    super.initState();
    fields = [
      NameField(text: "Full Name", service: widget.service),
      EmailField(text: "Email", service: widget.service),
      StudentIDField(text: "Student ID", service: widget.service),
      // LevelField(text: "Level", service: widget.service),
      PasswordField(text: "Password", service: widget.service),
      ConfirmPasswordField(text: "Confirm Password", service: widget.service),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.service.formKey,
      child: Padding(
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
            DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: null,
                  child: Text("Prefer not to say ( Optional )"),
                ),
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (value) {
                setState(() {
                  widget.service.gender = value;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<int>(
              value: selectedLevel,
              decoration: const InputDecoration(
                labelText: "Level",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text("undetrmined( Optional )"),
                ),
                DropdownMenuItem(value: 1, child: Text("1")),
                DropdownMenuItem(value: 2, child: Text("2")),
                DropdownMenuItem(value: 3, child: Text("3")),
                DropdownMenuItem(value: 4, child: Text("4")),
              ],
              onChanged: (value) {
                setState(() {
                  widget.service.level = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
