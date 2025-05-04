import 'package:store_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:store_app/Screens/ProfileScreen/profileScreen.dart';
import 'package:store_app/Screens/StoresScreen/StoresScreen.dart';
import 'package:store_app/Screens/loginScreen/loginService.dart';
import 'package:store_app/Screens/signupScreen/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginButtonSection extends StatelessWidget {
  const LoginButtonSection({super.key, required this.loginservice});
  final Loginservice loginservice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Prevent extra space
        children: [
          TextButton(
            onPressed: () async {
              bool successful = await loginservice.getCustomer(context);
              if (successful) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Homescreen()),
                );
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffc47c51),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Log In', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?   '),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const SignupScreen()),
                  );
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Color.fromARGB(255, 199, 142, 109)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
