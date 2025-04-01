import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Providers/guestModeProvider.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/ProfileScreen/HelpingWidgets/profileInfo.dart';
import 'package:prj/Screens/ProfileScreen/HelpingWidgets/profileOptions.dart';
import 'package:prj/Screens/ProfileScreen/HelpingWidgets/profilePic.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool isUploading = false;

  void setUploadingState(bool value) {
    setState(() {
      isUploading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (can, T) {
        if (isUploading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please wait until the upload finishes.'),
            ),
          );
        }
      },
      canPop: isUploading == true ? false : true,

      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'DopisBold',
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfilePicture(onUploadStateChanged: setUploadingState),
                const SizedBox(height: 16),
                const ProfileInfo(),
                const Divider(),
                const ProfileOptions(),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed:
                      isUploading
                          ? null
                          : () async {
                            if (FirebaseAuth.instance.currentUser == null) {
                              ref
                                  .watch(guestModeProvider.notifier)
                                  .disableGuestMode();
                            } else {
                              await FirebaseAuth.instance.signOut();
                            }
                            ref.invalidate(userProvider);
                            Navigator.pop(context);
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffc47c51),
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    FirebaseAuth.instance.currentUser != null
                        ? 'Logout'
                        : 'Sign In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
