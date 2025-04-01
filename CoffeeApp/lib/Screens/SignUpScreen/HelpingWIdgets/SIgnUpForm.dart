import 'package:flutter/material.dart';
import 'package:prj/Screens/LoginScreen/HelpingWidgets/signInButton.dart';
import 'package:prj/Screens/SignUpScreen/HelpingWIdgets/ImagePIcker.dart';
import 'package:prj/Screens/SignUpScreen/HelpingWIdgets/customPasswordField.dart';
import 'package:prj/Screens/SignUpScreen/HelpingWIdgets/fullNamefield.dart';
import 'package:prj/Screens/SignUpScreen/SignUpService/signUpService.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  late final Signupservice signupservice;

  @override
  void initState() {
    super.initState();
    signupservice = Signupservice(rebuild: setState, context: context);
  }

  @override
  Widget build(BuildContext context) {
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$';

    RegExp passRegix = RegExp(pattern);

    return Form(
      key: signupservice.formKey,
      child: Column(
        children: [
          UserImagePicker(
            onPickImage: signupservice.pickImage,
            fromProfile: false,
          ),

          TextFormField(
            onChanged: signupservice.checkEmail, // will be passed

            validator: (value) {
              if (value == null ||
                  !RegExp(
                    r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$",
                  ).hasMatch(value)) {
                return 'Enter a valid Email';
                // return null;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: const TextStyle(fontFamily: "DopisBold"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: const Icon(Icons.email, color: Color(0xffc47c51)),
              errorText: signupservice.emailError, // will be passed
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            validator: (value) {
              if (value == null) {
                return null;
              } else if (value.length < 4)
                return "Username must be 4 or more characters :D";
              return null;
            },
            onChanged: signupservice.checkUsername, // will pass
            decoration: InputDecoration(
              labelText: 'Username',
              labelStyle: const TextStyle(fontFamily: "DopisBold"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: const Icon(Icons.email, color: Color(0xffc47c51)),
              errorText: signupservice.usernameError, // will pass
            ),
          ),
          const SizedBox(height: 20),

          customPasswordfield(
            labelText: "Password",
            onChanged: (value) => signupservice.password = value,
            obsecurePassword: signupservice.obscurePassword1,
            onPressed:
                () => setState(
                  () =>
                      signupservice.obscurePassword1 =
                          !signupservice.obscurePassword1,
                ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password cannot be empty';
              }
              if (value.length < 6 || !passRegix.hasMatch(value)) {
                return 'Password must be at least 6 characters \nand it must contain \nuppercase, lowercase \nnumber, and special character';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          customPasswordfield(
            labelText: "Confirm Password",
            onChanged: (val) {},
            obsecurePassword: signupservice.obscurePassword2,
            onPressed:
                () => setState(
                  () =>
                      signupservice.obscurePassword2 =
                          !signupservice.obscurePassword2,
                ),
            validator: (value) {
              // WILL BE PASSED
              if (value == '' || value == null) {
                return 'Password can not be empty';
              } else if (value != signupservice.password)
                return 'Passwords do not match';

              if (!passRegix.hasMatch(value)) return 'Incorrect format.';
              return null;
            },
          ),

          const SizedBox(height: 20),

          fullNameField(
            onChanged:
                (value) => signupservice.fullName = value, // will be passed
          ),
          const SizedBox(height: 20),

          SignButton(
            isLoading: signupservice.isLoading,
            onPressed: signupservice.signUp,
            type: "Up",
          ),
        ],
      ),
    );
  }
}
