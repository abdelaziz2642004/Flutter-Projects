import 'dart:io';

import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/widgets/User_Image_Picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final _formKey = GlobalKey<FormState>();
  String _email = "", _password = "", _username = "", _fullname = "";

  bool _obscurePassword = true;
  bool _obscurePasswordd = true;

  String? _emailError;
  String? _usernameError;

  File? _selectedImage;
  bool isLoading = false;

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // else

      setState(() {
        _emailError = null;
        _usernameError = null;
      });

      // Check if the username already exists
      var usernameSnapshot = await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(_username)
          .get();

      if (usernameSnapshot.exists) {
        setState(() {
          _usernameError = 'Username already exists';
          isLoading = false;
        });
        return;
      }

      try {
        // Create user with Firebase Authentication
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.trim(),
          password: _password.trim(),
        );

        // Send email verification
        await userCredential.user!.sendEmailVerification();
        // save the image then sign out

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Users')
            .child('${userCredential.user!.uid}.jpg');

        if (_selectedImage != null) await storageRef.putFile(_selectedImage!);
        final imageUrl =
            _selectedImage != null ? storageRef.getDownloadURL() : '';
        // print(ImageUrl);

        // sign out to force the user to log in again
        await FirebaseAuth.instance.signOut();

        // Save user information in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _username.trim(),
          'fullname': _fullname,
          'email': _email.trim(),
          'alterEmail': _email.trim(),
          'firstEmail': _email.trim(),
          'imageUrl': imageUrl
        });

        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(_username)
            .set({
          'username': _username.trim(),
          'fullname': _fullname,
          'email': _email.trim(),
          'id': userCredential.user!.uid,
          'alterEmail': _email.trim(),
          'firstEmail': _email.trim()
        });
        setState(() {
          isLoading = false;
        });
        // Show success popup
        _showSuccessPopup();
      } catch (e) {
        if (!context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: ${e.toString()}')),
          );
        }

        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/sent.json',
                    width: 300, // Lottie animation
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Account created successfully! Please verify your email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
    // Navigator.of(context).pop(); nope
  }

  void _checkUsername(String value) async {
    if (value.isEmpty) {
      setState(() {
        _usernameError = null; // Clear error
      });
      return;
    }

    var usernameSnapshot = await FirebaseFirestore.instance
        .collection('UserNames')
        .doc(value)
        .get();

    setState(() {
      _usernameError =
          usernameSnapshot.exists ? 'Username already exists' : null;
    });
  }

  void _checkEmail(String value) async {
    // Check if the email exists in the Users collection
    var emailSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: value.trim())
        .get();

    var alterEmailSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('alterEmail', isEqualTo: value.trim())
        .get();

    setState(() {
      _emailError =
          emailSnapshot.docs.isNotEmpty || alterEmailSnapshot.docs.isNotEmpty
              ? 'Email already in use'
              : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isdark = ref.read(themeProvider);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/food.json', height: 200),
                  const SizedBox(height: 20),
                  const Text(
                    'Create an account and start cooking now!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      // color: Color.fromARGB(221, 255, 253, 253),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        UserImagePicker(onPickImage: (file) {
                          setState(() {
                            _selectedImage = file;
                          });
                        }),
                        TextFormField(
                          // style: const TextStyle(
                          // color: Color.fromARGB(209, 228, 223, 223)),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: isdark == ThemeMode.dark
                                    ? const Color.fromARGB(255, 229, 228, 228)
                                    : Colors.black),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 119, 0),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.person,
                                color: Color.fromARGB(255, 255, 119, 0)),
                            errorText: _usernameError,
                          ),
                          onChanged: _checkUsername,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                            } else if (value.length < 4) {
                              return 'Username must be at least 4 characters';
                            }
                            _username = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: const TextStyle(
                              // color: Color.fromARGB(209, 228, 223, 223)
                              ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: isdark == ThemeMode.dark
                                    ? const Color.fromARGB(255, 229, 228, 228)
                                    : Colors.black),
                            // labelStyle: const TextStyle(
                            //     color: Color.fromARGB(202, 255, 253, 253)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 119, 0),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.email,
                                color: Color.fromARGB(255, 255, 119, 0)),
                            errorText: _emailError,
                          ),
                          onChanged: _checkEmail,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            _email = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: const TextStyle(
                              // color: Color.fromARGB(209, 228, 223, 223)
                              ),
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: isdark == ThemeMode.dark
                                    ? const Color.fromARGB(255, 229, 228, 228)
                                    : Colors.black),
                            // labelStyle: const TextStyle(
                            //     color: Color.fromARGB(202, 255, 253, 253)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 119, 0),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromARGB(255, 255, 119, 0)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#]).{6,}$')
                                    .hasMatch(value)) {
                              return 'Password must be at least 6 characters long \n and include at least one:\n - upper character\n - lower character\n - digit \n -special character';
                            }
                            // _password = value;
                            return null;
                          },
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          style: const TextStyle(
                              // color: Color.fromARGB(209, 228, 223, 223)
                              ),
                          obscureText: _obscurePasswordd,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                                color: isdark == ThemeMode.dark
                                    ? const Color.fromARGB(255, 229, 228, 228)
                                    : Colors.black),
                            // labelStyle: const TextStyle(
                            //     color: Color.fromARGB(202, 255, 253, 253)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 119, 0)),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.lock,
                                color: Color.fromARGB(255, 255, 119, 0)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePasswordd
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePasswordd = !_obscurePasswordd;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Field is empty";
                            }
                            if (value != _password) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          maxLength: 50,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: TextStyle(
                                color: isdark == ThemeMode.dark
                                    ? const Color.fromARGB(255, 229, 228, 228)
                                    : Colors.black),

                            // labelStyle: const TextStyle(
                            //     color: Color.fromARGB(202, 255, 253, 253)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 119, 0),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color.fromARGB(255, 255, 119, 0)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            _fullname = value;
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            backgroundColor:
                                const Color.fromARGB(255, 255, 119, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        // style:
                        //     TextStyle(color: Color.fromARGB(133, 251, 251, 251)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Sign in!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 119, 0)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
