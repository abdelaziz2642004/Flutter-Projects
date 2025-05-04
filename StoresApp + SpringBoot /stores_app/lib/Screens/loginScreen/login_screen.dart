import 'package:store_app/Providers/autoLoginProviderLoadingProvider.dart';
import 'package:store_app/Screens/ProfileScreen/profileScreen.dart';
import 'package:store_app/Screens/loginScreen/loginService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'login_button_section.dart';
import 'login_fields_section.dart';
import 'login_header.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late Loginservice loginservice;

  @override
  void initState() {
    super.initState();
    loginservice = Loginservice(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loginLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  const CircularProgressIndicator(), // Show loading indicator
                if (!isLoading) ...[
                  const LoginHeader(),
                  LoginFieldsSection(loginservice: loginservice),
                  LoginButtonSection(loginservice: loginservice),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
