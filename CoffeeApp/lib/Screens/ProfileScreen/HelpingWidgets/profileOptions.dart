import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';
import 'package:prj/Screens/WishListScreen/WishlistScreen.dart';
import 'package:prj/Screens/FavoriteScreen/FavortieScreen.dart';
import 'package:prj/Screens/SettingsScreen./SettingsScreen.dart';

class ProfileOptions extends ConsumerWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user currentUser = ref.read(userProvider).value ?? user();

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Wishlist',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: Text('${currentUser.wishlist.items.length} items'),
          leading: const Icon(Icons.shopping_bag, color: Color(0xffc47c51)),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WishlistScreen()),
              ),
        ),
        ListTile(
          title: const Text(
            'Favorited Items',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: Text('${currentUser.favorited.length} items'),
          leading: const Icon(Icons.favorite, color: Color(0xffc47c51)),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              ),
        ),
        ListTile(
          title: const Text(
            'Settings & Preferences',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: const Text('Manage account settings'),
          leading: const Icon(Icons.settings, color: Color(0xffc47c51)),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ),
        ),
      ],
    );
  }
}
