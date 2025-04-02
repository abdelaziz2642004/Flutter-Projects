import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Surah.dart';
import 'package:quran_app/core/services/ApiService.dart';

// Provider to fetch Surahs with a parameter
final surahsProvider = FutureProvider<List<Surah>>((ref) async {
  try {
    return await QuranApiService.fetchSurahs();
  } catch (error) {
    throw Exception('Failed to fetch Surahs: $error');
  }
});
