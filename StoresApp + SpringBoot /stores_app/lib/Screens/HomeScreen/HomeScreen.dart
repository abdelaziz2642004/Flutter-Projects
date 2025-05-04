import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:store_app/Screens/FavoriteScreen/FavoritesScreen.dart';
import 'package:store_app/Screens/HomeScreen/HelpingWidgets/NavBar.dart';
import 'package:store_app/Screens/ProfileScreen/profileScreen.dart';
import 'package:store_app/Screens/StoresScreen/StoresScreen.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<Homescreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const StoreScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: TerracottaNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
