import 'package:flutter/material.dart';

import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData.light(),
      // Light theme
      darkTheme: ThemeData.dark(),
      // Dark theme
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Switch between light and dark themes
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dark Mode Toggle'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode; // Toggle dark mode
                });
              },
            ),
          ],
        ),
        body: Center(
          child: CustomBottomNavigationBar(selectedIndex: 0, onTap: (index) {}),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded, size: 28),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.headset_rounded, size: 28),
          label: 'Listening',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_rounded, size: 28),
          label: 'Tafsir',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded, size: 28),
          label: 'Recitation',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.download_rounded, size: 28),
          label: 'Downloads',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: CustomColors.lightText,
      unselectedItemColor: CustomColors.lightText.withAlpha(150),
      backgroundColor:
          isDarkMode
              ? const Color(0xFFffffff) // Dark background for dark mode
              : const Color(0xFFF8F5E4),
      // Light background for light mode
      elevation: isDarkMode ? 4.0 : 8.0,
      // Lower elevation for dark mode
      selectedLabelStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
    );
  }
}
