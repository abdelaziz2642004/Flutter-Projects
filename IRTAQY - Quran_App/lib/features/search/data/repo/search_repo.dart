import 'dart:async';
import 'package:quran_app/features/search/data/services/surah_frombakige.dart';
import '../models/index_model.dart';

class SearchRepo {
  final SurahformBakige surahformBakige;
  SearchRepo(this.surahformBakige);

  List<SurahVerse> results = [];
  List<SurahVerse>? _allVerses;

  Future<List<SurahVerse>> filterResults(String query) async {
    _allVerses ??= await surahformBakige.loadAllVersesfromcach(); // Load data once

    String queryNormalized = surahformBakige.normalizeArabic(query);
    List<String> queryWords = queryNormalized.split(' ');
    return _allVerses!.where((verse) {
      String verseText = verse.normalizedText;
      return queryWords.every((word) => verseText.contains(word));
    }).toList();
  }
}
