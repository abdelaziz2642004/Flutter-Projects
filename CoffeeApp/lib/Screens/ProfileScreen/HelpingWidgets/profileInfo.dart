import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';

class ProfileInfo extends ConsumerStatefulWidget {
  const ProfileInfo({super.key});

  @override
  ConsumerState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends ConsumerState<ProfileInfo> {
  String fullName = '';

  @override
  void initState() {
    super.initState();
    user currentUser = ref.read(userProvider).value ?? user();
    fullName = currentUser.fullName;
  }

  void _editFullName() {
    TextEditingController controller = TextEditingController(text: fullName);
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Full Name'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter new full name',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    fullName = controller.text;
                  });
                  Navigator.pop(context);
                  // save to database
                  // FirebaseFirestore firestore = FirebaseFirestore.instance;
                  FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'fullname': controller.text});
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  String capitalizeFirstLetterOfEachWord(String input) {
    return input
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word; // Skip empty words
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    user currentUser = ref.watch(userProvider).value ?? user();

    return Column(
      children: [
        if (currentUser.fullName != 'Guest')
          GestureDetector(
            onTap: _editFullName,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  capitalizeFirstLetterOfEachWord(fullName),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DopisBold',
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.edit, size: 18, color: Colors.grey),
              ],
            ),
          ),
        Text(currentUser.email, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
