import 'package:flutter/cupertino.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 24,
              color: Color(0xffc47c51),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Create an account to continue',
          style: TextStyle(
            fontSize: 15,
            // rgba(166,166,166,255)
            color: Color.fromARGB(255, 166, 166, 166),
          ),
        ),
      ],
    );
  }
}
