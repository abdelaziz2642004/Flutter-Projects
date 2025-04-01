import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String oldPassword = "";
  String newPassword = "";
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isSuccess = false;
  bool _isLoading = false;
  bool _isObscureOldPassword = true; // Flag to control old password visibility
  bool _isObscureNewPassword = true; // Flag to control new password visibility

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      User user = _auth.currentUser!;

      try {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );

        await user.reauthenticateWithCredential(credential);
        if (oldPassword == newPassword) {
          _showErrorDialog(
              'The new password must be different from the old password.');

          setState(() {
            _isSuccess = false;
            _isLoading = false;
          });
          return;
        }

        await user.updatePassword(newPassword);

        setState(() {
          _isSuccess = true;
          _isLoading = false;
        });

        // Show success for a longer duration
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop();
        });
      } catch (e) {
        _showErrorDialog('Error updating password: $e');
        setState(() {
          _isSuccess = false;
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Operation Failed'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/failed.json',
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isSuccess
            ? Column(
                children: [
                  Lottie.asset(
                    'assets/sucesss.json',
                    repeat: false, // Play once
                    animate: true, // Enable animation
                    onLoaded: (composition) {
                      // Use the composition duration to control display time
                      Future.delayed(composition.duration, () {
                        // Optional: do something after animation
                      });
                    },
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Password changed Successfully!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 84, 57, 204),
                    ),
                  )
                ],
              )
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscureOldPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscureOldPassword = !_isObscureOldPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscureOldPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        oldPassword = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscureNewPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscureNewPassword = !_isObscureNewPassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _isObscureNewPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (!RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$')
                            .hasMatch(value)) {
                          return 'Password must be at least 6 characters long \n and include upper, lower, digit, and special characters';
                        }
                        newPassword = value;
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _changePassword,
                      child: _isLoading
                          ? const SizedBox(
                              height: 12,
                              width: 12,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Update Password'),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
