import 'package:store_app/FieldsData/SuccessMessage.dart';
import 'package:store_app/Screens/signupScreen/signUpService.dart';
import 'package:flutter/material.dart';

List<Widget> signupButtonSection(
  SignUpService signUpService,
  BuildContext context,
) {
  return [
    TextButton(
      onPressed: () async {
        // signUpService.addStudent();
        // signUpService.getImage(context);
        // signUpService.getStudent(context);
        if (signUpService.formKey.currentState!.validate()) {
          //check now first if the id was used before
          bool exists = await signUpService.IDexist(context);
          if (exists) {
            showSuccessPopup(
              context,
              "❌ Sorry this ID is already taken, please try another",
            );
          } else {
            signUpService.addStudent(context);
          }
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffc47c51),
        minimumSize: const Size(320, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: const Text(
        maxLines: 1,
        'Sign Up',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const SizedBox(height: 12),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Already have an account?  '),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Color.fromARGB(255, 176, 123, 93)),
          ),
        ),
      ],
    ),
    const SizedBox(height: 50),
  ];
}
