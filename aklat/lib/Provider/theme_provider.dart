import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode?> {
  ThemeNotifier() : super(ThemeMode.dark) {
    // Default to dark theme
    loadTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt('theme') ?? 0; // Default to dark mode
    state = themeIndex == 0 ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> toggleTheme() async {
    final newTheme =
        state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    state = newTheme;
    await _saveTheme(newTheme);
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme',
        themeMode == ThemeMode.dark ? 1 : 0); // 1 for dark, 0 for light
  }
}

final themeProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode?>((ref) => ThemeNotifier());
