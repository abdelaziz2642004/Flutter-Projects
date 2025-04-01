import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class ChangeEmailScreen extends ConsumerStatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  ConsumerState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends ConsumerState<ChangeEmailScreen> {
  final TextEditingController _newEmailController = TextEditingController();
  bool _canChangeEmail = true; // Determines if email input is allowed
  bool alreadychanged = false;
  String? _alterEmail; // Holds the already set alternate email, if any

  @override
  void initState() {
    super.initState();
    _loadAlterEmail(); // Load alterEmail status when the screen loads
  }

  // Load the current user's alterEmail from Firestore
  Future<void> _loadAlterEmail() async {
    final userDoc = ref.read(profileDetailsProvider);

    setState(() {
      _alterEmail = userDoc['alterEmail'];
      final firstEmail = userDoc['alterEmail'];
      final mainEmail = userDoc['email'];

      if (firstEmail == mainEmail && mainEmail == _alterEmail) {
        return;
      } else if (firstEmail != _alterEmail) {
        _canChangeEmail =
            false; // Disable email input if already sent but ccan verify again
      }
      if (firstEmail == _alterEmail) {
        _canChangeEmail = false;
        alreadychanged = true;
      }
    });
  }

  // Regular expression for basic email validation
  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    return emailRegex.hasMatch(email);
  }

  Future<void> _verifyEmail(String newEmail) async {
    if (_isValidEmail(newEmail)) {
      try {
        User user = FirebaseAuth.instance.currentUser!;
        bool found = false;

        // Check if the new email already exists in Firestore
        String userName = '';
        final snapshot =
            await FirebaseFirestore.instance.collection('Users').get();
        for (final doc in snapshot.docs) {
          if (doc.id == user.uid) {
            userName = doc['username'];
            continue;
          }

          if (doc['email'] == newEmail || doc['alterEmail'] == newEmail) {
            found = true;
            break;
          }
        }

        // If the email exists in either field, show an error popup
        if (found) {
          _showErrorDialog(
              'This email is/was already used. Please choose a different email.');
          return;
        }

        // If the email does not exist, verify and update
        await user.verifyBeforeUpdateEmail(newEmail);

        // Now update the Firestore document to set the alternateEmail
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'alterEmail': newEmail,
        });

        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(userName)
            .update({
          'alterEmail': newEmail,
        });

        setState(() {
          _canChangeEmail = false; // Disable email input after update
          _alterEmail = newEmail; // Update the state with the new email
        });

        _showDialog("Verification Email Sent",
            "A verification email has been sent to ${_newEmailController.text.trim()}.");
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  void _resendVerification() async {
    User user = FirebaseAuth.instance.currentUser!;
    if (_alterEmail != null) {
      await user.verifyBeforeUpdateEmail(_alterEmail!);
      _showDialog("Verification Resent",
          "A verification email has been resent to $_alterEmail.");
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

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/sent.json',
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
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Email"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "WARNING: (YOU CAN ONLY DO THIS ONCE )\nWhether you verify the new Email or not, you will not be able to use the same email (old and new) to verify another account or sign up again.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _newEmailController,
                enabled: _canChangeEmail, // Disable input if email already set
                decoration: InputDecoration(
                  labelText: _canChangeEmail
                      ? "Enter the new email"
                      : "Alternate email already set",
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _canChangeEmail
                    ? () {
                        _verifyEmail(_newEmailController.text.trim());
                      }
                    : alreadychanged
                        ? null
                        : _resendVerification, // Resend verification if email is set
                child: Text(_canChangeEmail
                    ? "Send verification"
                    : alreadychanged
                        ? "Email was Already changed once"
                        : "Resend verification to $_alterEmail"),
              ),
              if (alreadychanged)
                Center(
                    child: Column(
                  children: [
                    Lottie.asset('assets/failed.json', height: 200),
                    const Text("Your Email was already changed once!"),
                  ],
                ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    super.dispose();
  }
}
