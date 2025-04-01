import 'package:flutter/material.dart';

class Bottomnavbar extends StatelessWidget {
  const Bottomnavbar({super.key, required int index, required this.rebuild})
    : _index = index;
  final void Function(int)? rebuild;

  final int _index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _index,
      onTap: rebuild,
      selectedItemColor: const Color.fromARGB(255, 255, 152, 0),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        _buildNavItem(Icons.home, 0),
        _buildNavItem(Icons.favorite_border, 1),
        _buildNavItem(Icons.shopping_bag_outlined, 2),
        _buildNavItem(Icons.notifications_none, 3),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, color: _index == index ? const Color(0xffc47c51) : Colors.grey),
          const SizedBox(height: 45),
          if (_index == index)
            Positioned(
              bottom: 0, // Adjust the position of the line
              child: Container(
                width: 12, // Adjust the width of the line
                height: 6, // Adjust the thickness
                decoration: BoxDecoration(
                  color: const Color(0xffc47c51), // Match the selected icon color
                  borderRadius: BorderRadius.circular(5),
                ),
                // color: Colors.orange, // Match the selected icon color
              ),
            ),
        ],
      ),
      label: '',
    );
  }
}
