import 'package:flutter/material.dart';
import 'package:store_app/Screens/HomeScreen/HelpingWidgets/NavBarItem.dart';

class TerracottaNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TerracottaNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff8f4f0), // Matching card color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavBarItem(
                icon: Icons.home,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              NavBarItem(
                icon: Icons.favorite,
                label: 'Favorites',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              NavBarItem(
                icon: Icons.person,
                label: 'Profile',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
