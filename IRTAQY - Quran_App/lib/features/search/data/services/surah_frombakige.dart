import 'package:hive_flutter/adapters.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/features/search/data/models/index_model.dart';

class SurahformBakige {
  List<SurahVerse> tempVerses = [];
  late Box _cacheBox;

  SurahformBakige() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    _cacheBox = await Hive.openBox('surah_cache');
  }

  Future<List<SurahVerse>> loadAllVersesfromcach() async {
    if (!_cacheBox.isOpen) await _initializeHive();

    if (_cacheBox.containsKey('allVerses')) {
      List<dynamic> cachedData = _cacheBox.get('allVerses');
      tempVerses =
          cachedData
              .map((e) => SurahVerse.fromMap(Map<String, dynamic>.from(e)))
              .toList();
    } else {
      List<SurahVerse> allVerses = loadAllVerses();
      _cacheBox.put('allVerses', allVerses.map((v) => v.toMap()).toList());
      tempVerses = allVerses;
    }
    return tempVerses;
  }

  List<SurahVerse> loadAllVerses() {
    List<SurahVerse> verses = [];
    for (int surahNumber = 1; surahNumber <= 114; surahNumber++) {
      for (int verse = 1; verse <= quran.getVerseCount(surahNumber); verse++) {
        String originalText = quran.getVerse(
          surahNumber,
          verse,
          verseEndSymbol: false,
        );
        verses.add(
          SurahVerse(
            surahNumber: surahNumber,
            surahName: quran.getSurahNameArabic(surahNumber),
            verseNumber: verse,
            verseText: originalText,
            normalizedText: normalizeArabic(originalText),
          ),
        );
      }
    }
    return verses;
  }

  String normalizeArabic(String text) {
    return text
        .replaceAll(RegExp(r'[\u064B-\u065F\u0670\u06D6-\u06ED]'), '')
        .replaceAll(RegExp(r'[^\u0600-\u06FF\s]'), '')
        .replaceAll(RegExp(r'[إأآ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll(RegExp(r'(^|\s)ال'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim()
        .toLowerCase();
  }
}
