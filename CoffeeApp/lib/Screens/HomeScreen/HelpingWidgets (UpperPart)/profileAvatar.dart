import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/ProfileScreen/profileScreen.dart';

class ProfileAvatar extends ConsumerWidget {
  const ProfileAvatar({super.key});

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user currentUser =
        ref
            .watch(userProvider)
            .value ?? // when we call invalidate , it will refresh :D
        user();
    return PopupMenuButton(
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 1, child: Text('Settings & Profile')),
          ],
      onSelected: (value) {
        if (value == 1) {
          _openProfile(context);
        }
      },
      child: CircleAvatar(
        radius: 20,
        backgroundImage:
            currentUser.ImageUrl.isNotEmpty
                ? CachedNetworkImageProvider(currentUser.ImageUrl)
                : const AssetImage('assets/images/profile.jpg')
                    as ImageProvider,
      ),
    );
  }
}
