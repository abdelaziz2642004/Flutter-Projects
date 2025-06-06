import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

// Theme StateNotifier
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme_mode') ?? 0;
    state = ThemeMode.values[themeIndex];
  }

  Future<void> toggleTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', ThemeMode.values.indexOf(newTheme));
  }
}

// Light Theme
final lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  useMaterial3: true,
  scaffoldBackgroundColor: CustomColors.lightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A3C34),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xFF1A3C34)),
    bodyMedium: TextStyle(color: Color(0xFF1A3C34)),
  ),
);

// Dark Theme
final darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  useMaterial3: true,
  scaffoldBackgroundColor: CustomColors.darkBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A3C34),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
