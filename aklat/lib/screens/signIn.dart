import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:Aklatoo/screens/forgotpassword.dart';
import 'package:Aklatoo/screens/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _formKey = GlobalKey<FormState>();
  String? _emailOrUsername;
  String? _password;
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Updated regex for password validation
  final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{6,}$');

  // Future<void> signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     String input = _emailOrUsername!.trim();
  //     String? email;

  //     try {
  //       if (input.contains('@')) {
  //         // If input contains '@', treat it as an email
  //         email = input;
  //         final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: email,
  //           password: _password!.trim(),
  //         );

  //         if (user.user != null) {
  //           ref.read(favoriteMealsProvider.notifier).empty();
  //         }
  //         print('hello from here');

  //         // logged in successfully
  //         final snapshot = await FirebaseFirestore.instance
  //             .collection('UserNames')
  //             .doc(input)
  //             .get();
  //         final mainEmail = snapshot.data()!['email'];
  //         final alterEmail = snapshot.data()!['alterEmail'];

  //         if (alterEmail == email) {
  //           await FirebaseFirestore.instance
  //               .collection('UserNames')
  //               .doc(input)
  //               .update({
  //             'email': alterEmail,
  //             'alterEmail': mainEmail,
  //           });

  //           await FirebaseFirestore.instance
  //               .collection('Users')
  //               .doc(user.user!.uid)
  //               .update({'email': alterEmail, 'alterEmail': mainEmail});
  //         }
  //       } else {
  //         // If input is a username, check Firestore for user details
  //         final snapshot = await FirebaseFirestore.instance
  //             .collection('UserNames')
  //             .doc(input)
  //             .get();

  //         if (snapshot.exists) {
  //           final mainEmail = snapshot.data()!['email'];
  //           final alterEmail = snapshot.data()!['alterEmail'];

  //           // Attempt to sign in with mainEmail first
  //           try {
  //             final user =
  //                 await FirebaseAuth.instance.signInWithEmailAndPassword(
  //               email: mainEmail,
  //               password: _password!.trim(),
  //             );
  //             if (user.user != null) {
  //               ref.read(favoriteMealsProvider.notifier).empty();
  //               setState(() {
  //                 _isLoading = false;
  //               });
  //               return; // Successful sign-in, exit the method
  //             }
  //           } catch (e) {
  //             // If sign-in with mainEmail fails, swap the emails
  //             await FirebaseFirestore.instance
  //                 .collection('UserNames')
  //                 .doc(input)
  //                 .update({
  //               'email': alterEmail,
  //               'alterEmail': mainEmail,
  //             });

  //             // Now try signing in with alterEmail
  //             try {
  //               final user =
  //                   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //                 email: alterEmail,
  //                 password: _password!.trim(),
  //               );
  //               if (user.user != null) {
  //                 // Update Firestore with the new email
  //                 await FirebaseFirestore.instance
  //                     .collection('Users')
  //                     .doc(user.user!.uid)
  //                     .update({'email': alterEmail, 'alterEmail': mainEmail});

  //                 ref.read(favoriteMealsProvider.notifier).empty();
  //                 setState(() {
  //                   _isLoading = false;
  //                 });
  //                 return; // Successful sign-in, exit the method
  //               }
  //             } catch (e) {
  //               // If sign-in with alterEmail also fails
  //               _showErrorDialog(
  //                   'Invalid credentials. Please check your username/email and password.');
  //             }
  //           }
  //         } else {
  //           _showErrorDialog(
  //               'Invalid credentials. Please check your username/email and password.');
  //         }
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     } catch (e) {
  //       _showErrorDialog(
  //           'Invalid credentials. Please check your username/email and password.');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  // Future<void> signIn() async {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     String input = _emailOrUsername!.trim();
  //     String? email;

  //     try {
  //       if (input.contains('@')) {
  //         // If input contains '@', treat it as an email
  //         email = input;
  //         final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //           email: email,
  //           password: _password!.trim(),
  //         );
  //         if (user.user != null) {
  //           ref.read(favoriteMealsProvider.notifier).empty();
  //         }
  //       } else {
  //         // If input is a username, check Firestore for user details
  //         final snapshot = await FirebaseFirestore.instance
  //             .collection('UserNames')
  //             .doc(input)
  //             .get();

  //         if (snapshot.exists) {
  //           final mainEmail = snapshot.data()!['email'];
  //           final alterEmail = snapshot.data()!['alterEmail'];

  //           // Attempt to sign in with mainEmail first
  //           try {
  //             final user =
  //                 await FirebaseAuth.instance.signInWithEmailAndPassword(
  //               email: mainEmail,
  //               password: _password!.trim(),
  //             );
  //             if (user.user != null) {
  //               ref.read(favoriteMealsProvider.notifier).empty();
  //               setState(() {
  //                 _isLoading = false;
  //               });
  //               return; // Successful sign-in, exit the method
  //             }
  //           } catch (e) {
  //             // If sign-in with mainEmail fails, swap the emails
  //             await FirebaseFirestore.instance
  //                 .collection('UserNames')
  //                 .doc(input)
  //                 .update({
  //               'email': alterEmail,
  //               'alterEmail': mainEmail,
  //             });

  //             await FirebaseFirestore.instance
  //                 .collection('Users')
  //                 .doc(user.uid)
  //                 .update({
  //               'email': alterEmail,
  //             });

  //             // Now try signing in with alterEmail
  //             try {
  //               final user =
  //                   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //                 email: alterEmail,
  //                 password: _password!.trim(),
  //               );
  //               if (user.user != null) {
  //                 ref.read(favoriteMealsProvider.notifier).empty();
  //                 setState(() {
  //                   _isLoading = false;
  //                 });
  //                 return; // Successful sign-in, exit the method
  //               }
  //             } catch (e) {
  //               // If sign-in with alterEmail also fails
  //               _showErrorDialog(
  //                   'Invalid credentials. Please check your username/email and password.');
  //             }
  //           }
  //         } else {
  //           _showErrorDialog(
  //               'Invalid credentials. Please check your username/email and password.');
  //         }
  //         setState(() {
  //           _isLoading = false;
  //         });
  //       }
  //     } catch (e) {
  //       _showErrorDialog(
  //           'Invalid credentials. Please check your username/email and password.');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   }
  // }

  void _showErrorDialog(String message) {
    if (!mounted) return; // Check if the widget is still mounted
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text(message),
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

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String input = _emailOrUsername!.trim();
      String? email;

      try {
        if (input.contains('@')) {
          // If input contains '@', treat it as an email
          email = input;

          final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: _password!.trim(),
          );
          ref.read(favoriteMealsProvider.notifier).empty();

          if (user.user != null) {
            // print(
            //     "hererererererhererererererhererererererhererererererherererererer");
            // logged in successfully
            final snapshot = await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.user!.uid)
                .get();
            final userName = snapshot.data()!['username'];
            final mainEmail = snapshot.data()!['email'];
            final alterEmail = snapshot.data()!['alterEmail'];
            // print(mainEmail);
            // print(alterEmail);
            // print(userName);
            if (alterEmail == email) {
              await FirebaseFirestore.instance
                  .collection('UserNames')
                  .doc(userName)
                  .update({
                'email': alterEmail,
                'alterEmail': mainEmail,
              });

              await FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.user!.uid)
                  .update({'email': alterEmail, 'alterEmail': mainEmail});
            }
          }
        } else {
          // If input is a username, check Firestore for user details
          final snapshot = await FirebaseFirestore.instance
              .collection('UserNames')
              .doc(input)
              .get();

          if (snapshot.exists) {
            final mainEmail = snapshot.data()!['email'];
            final alterEmail = snapshot.data()!['alterEmail'];

            // Attempt to sign in with mainEmail first
            try {
              final user =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: mainEmail,
                password: _password!.trim(),
              );
              if (user.user != null) {
                ref.read(favoriteMealsProvider.notifier).empty();
                ref.read(profileDetailsProvider.notifier).empty();
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
                return; // Successful sign-in, exit the method
              }
            } catch (e) {
              // If sign-in with mainEmail fails, swap the emails
              await FirebaseFirestore.instance
                  .collection('UserNames')
                  .doc(input)
                  .update({
                'email': alterEmail,
                'alterEmail': mainEmail,
              });

              // Now try signing in with alterEmail
              try {
                final user =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: alterEmail,
                  password: _password!.trim(),
                );
                if (user.user != null) {
                  // Update Firestore with the new email
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(user.user!.uid)
                      .update({'email': alterEmail, 'alterEmail': mainEmail});

                  ref.read(favoriteMealsProvider.notifier).empty();
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                  return; // Successful sign-in, exit the method
                }
              } catch (e) {
                // If sign-in with alterEmail also fails
                _showErrorDialog(
                    'Invalid credentials. Please check your username/email and password.');
              }
            }
          } else {
            _showErrorDialog(
                'Invalid credentials. Please check your username/email and password.');
          }
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      } catch (e) {
        _showErrorDialog(
            'Invalid credentials. Please check your username/email and password.');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const FaIcon(
                      //   FontAwesomeIcons.utensils,
                      //   size: 100,
                      //   color: Color.fromARGB(255, 255, 119, 0),
                      // ),
                      Lottie.asset('assets/food.json', height: 200),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          // color: Color.fromARGB(221, 255, 255, 255),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Email or Username TextField
                      TextFormField(
                        // style: const TextStyle(
                        //     color: Color.fromARGB(209, 228, 223, 223)),
                        onChanged: (value) {
                          _emailOrUsername = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username or email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username or Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.orange,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 255, 119, 0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password TextField
                      TextFormField(
                        // style: const TextStyle(
                        // color: Color.fromARGB(209, 228, 223, 223)),
                        onChanged: (value) {
                          _password = value;
                        },
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!_passwordRegExp.hasMatch(value)) {
                            return 'Password must contain at least:\n- One uppercase letter\n- One lowercase letter\n- One number\n- One special character\n- Minimum 6 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // labelStyle: const TextStyle(
                          //   color: Color.fromARGB(255, 255, 255, 255),
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 255, 119, 0),
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 255, 119, 0),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 255, 119, 0),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        const ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 119, 0)),
                              )),
                        ],
                      ),

                      // Sign In Button
                      ElevatedButton(
                        onPressed:
                            _isLoading ? null : signIn, // Disable if loading
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 119, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator() // Show loading indicator
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                      ),
                      const SizedBox(height: 20),

                      // Not a member? Sign Up!
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Not a member?",
                            // style: TextStyle(
                            //     color: Color.fromARGB(137, 255, 255, 255)),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Signup()));
                            },
                            child: const Text(
                              "Sign up!",
                              style: TextStyle(
                                color: Colors.orange,
                              ),
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
        ),
      ),
    );
  }
}
