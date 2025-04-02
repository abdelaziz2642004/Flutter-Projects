import 'package:flutter/material.dart';

class RecitationViewModel {
  String _selectedReciter = 'Mishary Rashid';
  int _selectedJuz = 1;
  bool _showShortSurahs = false;

  final List<Map<String, dynamic>> _allSurahs = [
    {
      'name': 'Al-Fatiha',
      'transliteration': 'Al-Fatiha',
      'reciter': 'Mishary Rashid',
      'juz': 1,
      'length': 7,
      'progress': 0.3,
    },
    {
      'name': 'Al-Baqarah',
      'transliteration': 'Al-Baqarah',
      'reciter': 'Abdul Basit',
      'juz': 1,
      'length': 286,
      'progress': 0.1,
    },
    {
      'name': 'Al-Imran',
      'transliteration': 'Al-Imran',
      'reciter': 'Mishary Rashid',
      'juz': 3,
      'length': 200,
      'progress': 0.5,
    },
  ];

  List<Map<String, dynamic>> _filteredSurahs = [];

  // Getters for UI access
  String get selectedReciter => _selectedReciter;
  int get selectedJuz => _selectedJuz;
  bool get showShortSurahs => _showShortSurahs;
  List<Map<String, dynamic>> get filteredSurahs => _filteredSurahs;

  // Logic to filter surahs
  void filterSurahs() {
    _filteredSurahs =
        _allSurahs.where((surah) {
          final matchesReciter = surah['reciter'] == _selectedReciter;
          final matchesJuz = surah['juz'] == _selectedJuz;
          final matchesLength = !_showShortSurahs || surah['length'] < 150;
          return matchesReciter && matchesJuz && matchesLength;
        }).toList();
  }

  // Update methods
  void updateReciter(String newReciter) {
    _selectedReciter = newReciter;
    filterSurahs();
  }

  void updateJuz(int newJuz) {
    _selectedJuz = newJuz;
    filterSurahs();
  }

  void updateLengthFilter(bool showShort) {
    _showShortSurahs = showShort;
    filterSurahs();
  }

  // Play surah action
  void playSurah(String surah) {
    // In a real app, this might interact with a service or audio player
    // For now, we'll simulate it with a print statement or pass it back to the UI
    debugPrint('Playing $surah');
  }
}
