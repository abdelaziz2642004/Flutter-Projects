import 'dart:async'; // Add this import

import 'package:Aklatoo/Provider/favorite_provider.dart';
import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final User user;

  const VerificationScreen({required this.user, super.key});

  @override
  ConsumerState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen>
    with SingleTickerProviderStateMixin {
  bool isVerifying = false;
  bool isResendCooldown = false;
  String verificationMessage = '';

  final int resendCoolMinutes = 2;
  late AnimationController _buttonController;
  late Animation<Offset> _slideAnimation;
  Timer? _timer; // Timer for auto-refresh

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileDetailsProvider.notifier).empty();

      ref.read(favoriteMealsProvider.notifier).empty();
    });

    // Initialize animation controller for slide transition
    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _buttonController.forward();

    // Start the auto-refresh timer
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      checkVerificationStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to avoid memory leaks
    _buttonController.dispose();
    super.dispose();
  }

  Future<void> sendVerificationEmail() async {
    if (isResendCooldown) {
      setState(() {
        verificationMessage =
            'Please wait before requesting another verification email.';
      });
      return;
    }

    setState(() {
      isVerifying = true;
      verificationMessage = '';
    });

    try {
      await widget.user.sendEmailVerification();
      setState(() {
        verificationMessage = 'Verification email sent!';
        isResendCooldown = true;
      });

      Future.delayed(Duration(minutes: resendCoolMinutes), () {
        setState(() {
          isResendCooldown = false;
        });
      });
    } catch (e) {
      setState(() {
        verificationMessage = 'Error sending verification email.';
      });
    } finally {
      setState(() {
        isVerifying = false;
      });
    }
  }

  Future<void> checkVerificationStatus() async {
    setState(() {
      isVerifying = true;
      verificationMessage = '';
    });

    await widget.user.reload();
    User updatedUser = FirebaseAuth.instance.currentUser!;

    if (updatedUser.emailVerified) {
      Navigator.pop(context);
    } else {
      setState(() {
        verificationMessage = '';
      });
    }

    setState(() {
      isVerifying = false;
    });
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    await widget.user.reload();
    User updatedUser = FirebaseAuth.instance.currentUser!;

    if (updatedUser.emailVerified) {
      return true; // Allow navigation if the email is verified
    } else {
      setState(() {
        verificationMessage = 'Please verify your email before going back.';
      });
      return false; // Prevent navigation if email is not verified
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AnimatedOpacity(
                      opacity: 1.0,
                      duration: Duration(milliseconds: 700),
                      child: Text(
                        'Please verify your email address.',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),

                    AnimatedOpacity(
                      opacity: verificationMessage.isNotEmpty ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        verificationMessage,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Resend verification email button
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: isVerifying || isResendCooldown
                            ? null
                            : () {
                                sendVerificationEmail();
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: isResendCooldown
                            ? Text(
                                'Wait ${resendCoolMinutes}mins',
                              )
                            : const Text(
                                'Resend Verification Email',
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 500),
                      child: ElevatedButton(
                        onPressed: () {
                          signOut();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Cancel and Sign Out',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
