import 'package:flutter/cupertino.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'Login',
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
          'Enter your email and password to log in',
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
