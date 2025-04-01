import 'dart:async'; // Add this for Timer

import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:Aklatoo/screens/change_email.dart';
import 'package:Aklatoo/screens/change_password.dart';
import 'package:Aklatoo/widgets/ChangeImage.dart'; // Update with correct path
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  bool isLoading = false;
  bool canRefresh = true; // New variable to manage refresh button availability

  Timer? refreshTimer; // Timer to control the button availability

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _animationController.forward();

    // Start the timer to make the refresh button available every 5 seconds
    refreshTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        canRefresh = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    refreshTimer?.cancel(); // Stop the timer when the widget is disposed
    super.dispose();
  }

  Future<void> _refreshProfile() async {
    if (!canRefresh) return; // Prevent refresh if the button is not available

    setState(() {
      isLoading = true;
      canRefresh = false; // Disable the button after refresh
    });

    // Refresh profile logic
    ref.read(profileDetailsProvider.notifier).empty();

    setState(() {
      isLoading = false;
    });
  }

  String capitalizeFirstLetterOfEachWord(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word; // Skip empty words
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  Future<void> _updateProfilePicture(File pickedImage) async {
    setState(() {
      isLoading = true;
    });

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    try {
      ref
          .read(profileDetailsProvider.notifier)
          .updateProfilePicture(pickedImage);

      // Refresh the profile to show the new image
      await _refreshProfile();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile picture')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    // Show confirmation dialog
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) return; // User canceled

    setState(() {
      isLoading = true;
    });

    try {
      final String idd = currentUser.uid;
      final userDoc = ref.read(profileDetailsProvider);

      final String userName = userDoc['username'];

      await currentUser.delete();

      await FirebaseFirestore.instance.collection('Users').doc(idd).delete();

      await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(userName)
          .delete();

      if (userDoc['imageUrl'] != '') {
        await FirebaseStorage.instance
            .ref()
            .child('Users')
            .child('$idd.jpg')
            .delete();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userdata = ref.watch(profileDetailsProvider);
    final String fullname = userdata['fullname'] ?? 'Loading Name';
    final String email = userdata['email'] ?? 'Loading Email';
    final String username = userdata['username'] ?? 'Loading Username';
    String imageUrl = userdata['imageUrl'] ?? '';

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: CircleAvatar(
                      backgroundImage: imageUrl == ''
                          ? const AssetImage('assets/Profile.jpg')
                          : CachedNetworkImageProvider(imageUrl),
                      radius: 100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      capitalizeFirstLetterOfEachWord(fullname),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Userr(onPickImage: _updateProfilePicture),
                      ),
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              imageUrl = '';
                              File? hello;
                              ref
                                  .read(profileDetailsProvider.notifier)
                                  .updateProfilePicture(hello);
                              _refreshProfile();
                            });
                          },
                          icon: const Icon(
                            Icons.photo_camera,
                            size: 20,
                            // color: Color.fromARGB(255, 231, 147, 72),
                          ),
                          label: const Text(
                            'Remove Image',
                            style: TextStyle(
                              fontSize: 15,
                              // color: Color.fromARGB(255, 239, 137, 47),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SlideTransition(
                    position: _slideAnimation,
                    child: buildProfileField(
                        Icons.email, email, "Email:  ", colorScheme),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: buildProfileField(
                        Icons.person_2, username, "Username:  ", colorScheme),
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const ChangeEmailScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      child: Text(
                        '    Change Email    ',
                        style: TextStyle(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                  const Text(
                    " \nNote: if you changed your Email, \n you have to log in again and refresh to see the changes on your profile screen <3 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color.fromARGB(255, 2, 111, 8)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        _deleteAccount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      child: Text(
                        '    Delete Account    ',
                        style: TextStyle(color: colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: canRefresh
            ? _refreshProfile
            : null, // Only allow refresh if canRefresh is true
        tooltip: 'Refresh Profile',
        child: canRefresh
            ? isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh)
            : const Text('5s'),
      ),
    );
  }

  Widget buildProfileField(
      IconData icon, String value, String label, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            "$label $value",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
