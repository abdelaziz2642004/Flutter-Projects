import 'package:Aklatoo/Provider/profileDetails.dart';
import 'package:Aklatoo/Provider/theme_provider.dart';
import 'package:Aklatoo/model/meal.dart';
import 'package:Aklatoo/screens/change_email.dart';
import 'package:Aklatoo/screens/change_password.dart';
import 'package:Aklatoo/widgets/filter_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});
  @override
  ConsumerState<FiltersScreen> createState() => FiltersScreenState();
}

class FiltersScreenState extends ConsumerState<FiltersScreen> {
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
      final userDoc = ref.read(profileDetailsProvider);

      final String userName = userDoc['username'];

      await currentUser.delete();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(idd) // Assuming username is stored in userdata
          .delete();

      await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(userName) // Assuming username is stored in userdata
          .delete();

      // Delete from Storage
      if (userDoc['imageUrl'] != '') {
        await FirebaseStorage.instance
            .ref()
            .child('Users')
            .child('$idd.jpg')
            .delete();
      }

      // Delete user from Authentication
    } catch (error) {
      // Handle errors (optional)
      // print('Error deleting account: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting account: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDarkMode = ref.read(themeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings & UI')),
      body: ListView(
        padding:
            const EdgeInsets.all(16.0), // Added padding around the entire list
        children: [
          // Meal Preferences Section
          const Text(
            "Meal Preferences & Looks",
          ),
          const SizedBox(height: 12), // Space after the section title
          const FilterItem(
            filter: Filters.gluten,
            title: "Gluten Free",
            midtitle: "gluten-free",
          ),
          const SizedBox(height: 12), // Space between items
          const FilterItem(
            filter: Filters.lactose,
            title: "Lactose Free",
            midtitle: "lactose-free",
          ),
          const SizedBox(height: 12),
          const FilterItem(
            filter: Filters.vegan,
            title: "Vegan",
            midtitle: "vegan",
          ),
          const SizedBox(height: 12),
          const FilterItem(
            filter: Filters.vegetarian,
            title: "Vegetarian",
            midtitle: "vegetarian",
          ),
          const SizedBox(height: 12),

          // Dark Mode Switch
          SwitchListTile(
            title: Text(
              "Dark Mode",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
            ),
            subtitle: Text(
              'Turn the app to dark/light mode',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(),
            ),
            value: isDarkMode == ThemeMode.dark,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            onChanged: (value) {
              // print(isDarkMode == ThemeMode.dark);
              // print(isDarkMode);

              ref.read(themeProvider.notifier).toggleTheme();
              isDarkMode = isDarkMode == ThemeMode.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
            },
          ),
          const Divider(height: 32), // Divider for visual separation

          // Account Settings Section
          const Text(
            "Account Settings",
          ),
          const SizedBox(height: 12), // Space after the section title
          ListTile(
            title: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode == ThemeMode.dark
                    ? const Color.fromARGB(255, 201, 168, 230)
                    : const Color.fromARGB(255, 167, 63, 252),
              ),
              onPressed: () {
                // Navigate to ChangePasswordScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordScreen(),
                  ),
                );
              },
              child: Text(
                "Change Password",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isDarkMode == ThemeMode.dark
                          ? const Color.fromARGB(255, 126, 0, 236)
                          : const Color.fromARGB(255, 245, 225, 255),
                    ),
              ),
            ),
          ),

          ListTile(
            title: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode == ThemeMode.dark
                    ? const Color.fromARGB(255, 201, 168, 230)
                    : const Color.fromARGB(255, 167, 63, 252),
              ),
              onPressed: () {
                // Navigate to ChangeEmailScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeEmailScreen(),
                  ),
                );
              },
              child: Text(
                "Change Email",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isDarkMode == ThemeMode.dark
                          ? const Color.fromARGB(255, 126, 0, 236)
                          : const Color.fromARGB(255, 245, 225, 255),
                    ),
              ),
            ),
          ),

          ListTile(
            title: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode == ThemeMode.dark
                    ? const Color.fromARGB(255, 201, 168, 230)
                    : const Color.fromARGB(255, 167, 63, 252),
              ),
              onPressed: () {
                // Navigate to ChangeEmailScreen
                _deleteAccount(context);
              },
              child: Text(
                "Delete Account",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: isDarkMode == ThemeMode.dark
                          ? const Color.fromARGB(255, 126, 0, 236)
                          : const Color.fromARGB(255, 245, 225, 255),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
