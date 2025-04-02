import 'package:quran/quran.dart' as quran;

class QuranService {
  QuranService._();

  static final QuranService _instance = QuranService._();

  static QuranService get instance => _instance;

  Future<String> getAudioUrl(int id) async {
    return quran.getAudioURLBySurah(id);
  }

  Future<List<String>> getSurahs() async {
    List<String> surahs = [];
    for (int i = 1; i <= 114; i++) {
      surahs.add(quran.getSurahName(i));
    }
    return surahs;
  }

  Future<Map<int, List<int>>> getJuz(int juz) async {
    return quran.getSurahAndVersesFromJuz(juz);
  }

  Future<List<int>> getAyahs(int juz) async {
    Map<int, List<int>> surahAndVerses = await getJuz(juz);
    return surahAndVerses.values.toList()[0];
  }
}