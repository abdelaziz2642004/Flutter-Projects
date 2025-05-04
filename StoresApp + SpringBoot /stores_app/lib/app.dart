import 'package:hive_flutter/hive_flutter.dart';
import 'package:store_app/Screens/HomeScreen/HomeScreen.dart';
import 'package:store_app/Screens/loginScreen/login_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('customer'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading data')),
          );
        } else {
          final box = snapshot.data as Box;
          if (box.isEmpty) {
            return const LoginScreen();
          } else {
            return const Homescreen();
          }
        }
      },
    );
  }
}
