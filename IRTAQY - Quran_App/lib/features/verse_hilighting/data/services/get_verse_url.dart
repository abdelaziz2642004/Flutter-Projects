import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran/quran.dart' as quran;

class GetVerseUrl {
  final int surahNumber;

  GetVerseUrl(this.surahNumber);

  /// 🔹 الحصول على المسار المحلي لملف الصوت بدون تحميل
  Future<String> getLocalPath(int surahNumber, int verseNumber) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/surah_$surahNumber/verse_$verseNumber.mp3';
  }

  /// 🔹 التحقق مما إذا كانت السورة محملة بالكامل
  Future<bool> isSurahDownloaded(int surahNumber) async {
    final dir = await getApplicationDocumentsDirectory();
    final surahDir = Directory('${dir.path}/surah_$surahNumber');

    if (!await surahDir.exists()) {
      return false; // إذا لم يكن هناك مجلد للسورة، فهي غير محملة
    }

    int verseCount = quran.getVerseCount(surahNumber);
    for (int i = 1; i <= verseCount; i++) {
      final file = File('${surahDir.path}/verse_$i.mp3');
      if (!await file.exists()) {
        return false; // إذا كان هناك آية مفقودة، فالسورة غير مكتملة
      }
    }

    return true; // جميع الآيات موجودة
  }

  /// 🔹 تحميل آية واحدة فقط إذا لم تكن موجودة
  Future<void> downloadVerse(int surahNumber, int verseNumber) async {
    final url = quran.getAudioURLByVerse(surahNumber, verseNumber);
    final filePath = await getLocalPath(surahNumber, verseNumber);

    if (await File(filePath).exists()) {
      return;
    }

    try {
      final dio = Dio();
      await dio.download(url, filePath);
    } catch (e) {}
  }

  /// 🔹 تحميل السورة بالكامل إذا لم تكن موجودة
  Future<void> downloadSurah(int surahNumber) async {
    if (await isSurahDownloaded(surahNumber)) {
      return;
    }

    for (int i = 1; i <= quran.getVerseCount(surahNumber); i++) {
      await downloadVerse(surahNumber, i);
    }
  }
}
