import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Screens/LoginScreen/HelpingWidgets/EmailField.dart';
import 'package:prj/Screens/LoginScreen/HelpingWidgets/passwordField.dart';
import 'package:prj/Screens/LoginScreen/HelpingWidgets/signInButton.dart';
import 'package:prj/Screens/LoginScreen/LoginService/LoginService.dart';
import 'package:prj/Screens/forgotPasswordScreen/forgotScreen.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  late final LoginService loginService;

  @override
  void initState() {
    super.initState();
    loginService = LoginService(context: context, rebuild: setState);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginService.formKey,
      child: Column(
        children: [
          EmailorUsernameField(
            onChanged: (value) => loginService.emailOrUsername = value,
          ),
          const SizedBox(height: 20),
          PasswordField(
            obscurePassword: loginService.obscurePassword,
            onChanged: (value) => loginService.password = value,
            toggleVisibility:
                () => setState(
                  () =>
                      loginService.obscurePassword =
                          !loginService.obscurePassword,
                ),
            labelText: "Password",
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed:
                    () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ForgotPasswordScreen(),
                      ),
                    ),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xffc47c51),
                    fontFamily: "DopisBold",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SignButton(
            isLoading: loginService.isLoading,
            onPressed: () {
              loginService.signIn(ref);
            },
            type: "In",
          ),
        ],
      ),
    );
  }
}
