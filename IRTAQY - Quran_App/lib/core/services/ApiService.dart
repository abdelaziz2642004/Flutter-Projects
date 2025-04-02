import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quran_app/core/Models/AudioFile.dart';
import 'package:quran_app/core/Models/Surah.dart';

class QuranApiService {
  static const String baseUrl = "https://api.quran.com/api/v4";

  // Fetch all Surahs
  static Future<List<Surah>> fetchSurahs() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/chapters"));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body)['chapters'];
        return jsonList.map((json) => Surah.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load Surahs");
      }
    } catch (e) {
      throw Exception("Failed to load Surahs");
    }
  }

  // Fetch all Reciters
  // static Future<List<Reciter>> fetchReciters() async {
  //   final response = await http.get(
  //     Uri.parse("$baseUrl/resources/recitations"),
  //   );
  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonList = json.decode(response.body)['recitations'];
  //     List<Reciter> list =
  //         jsonList.map((json) => Reciter.fromJson(json)).toList();
  //     return list;
  //   } else {
  //     throw Exception("Failed to load Reciters");
  //   }
  // }

  static Future<AudioFile> fetchSurahAudio(int reciterId, int surahId) async {
    try {
      final url = Uri.parse("$baseUrl/chapter_recitations/$reciterId/$surahId");

      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return AudioFile.fromJson(jsonData["audio_file"]);
      } else {
        throw Exception("Failed to load audio file");
      }
    } catch (e) {
      throw Exception("Failed to load audio file");
    }
  }
}
