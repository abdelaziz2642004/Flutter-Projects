import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/filtersProvider.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/SettingsScreen./HelpingWIdgets/switchListTile.dart';
import 'package:prj/Screens/changePassword.dart/changePasswordScreen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  void _toggleFilter(filters filter, bool val) {
    ref.read(filterProvider.notifier).setFilter(filter, val);
  }

  Future<void> _deleteAccount(BuildContext context) async {
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

    try {
      // Delete from Firestore
      final String idd = currentUser.uid;

      final user USER = ref.read(userProvider).value ?? user();
      String userName = USER.userName;

      await currentUser.delete();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(idd) // Assuming username is stored in userdata
          .delete();

      await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(userName) // Assuming username is stored in userdata
          .delete();


      // Delete user from Authentication
    } catch (error) {
      // Handle errors (optional)
      // print('Error deleting account: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please log out and log in again because this operation is sensitive :D',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterValues = ref.watch(filterProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            if (FirebaseAuth.instance.currentUser != null) ...[
              ListTile(
                title: const Text('Change Password'),
                trailing: const Icon(Icons.lock, color: Color(0xffc47c51)),
                onTap: () {
                  // Handle password change
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Delete Account'),
                trailing: const Icon(Icons.delete, color: Colors.red),
                onTap: () {
                  // Handle account deletion
                  _deleteAccount(context);
                },
              ),
              const Divider(),
            ],
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Filter Coffees',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Turning off one will remove all the drinks that apply to it',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            customSwitchTile(
              filterValues[filters.isDairy] ?? true,
              _toggleFilter,
              filters.isDairy,
            ),
            customSwitchTile(
              filterValues[filters.isDecaf] ?? true,
              _toggleFilter,
              filters.isDecaf,
            ),
            customSwitchTile(
              filterValues[filters.isSugary] ?? true,
              _toggleFilter,
              filters.isSugary,
            ),
            customSwitchTile(
              filterValues[filters.containsCaffeine] ?? true,
              _toggleFilter,
              filters.containsCaffeine,
            ),
            customSwitchTile(
              filterValues[filters.containsNuts] ?? true,
              _toggleFilter,
              filters.containsNuts,
            ),
          ],
        ),
      ),
    );
  }
}
