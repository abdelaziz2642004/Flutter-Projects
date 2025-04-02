import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/core/view_models/recitation_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/Reciter.dart';

class RecitationDetails extends Cubit<RecitationStates> {
  RecitationDetails._() : super(InitialState()) {
    init();
    // Don't remove on every init unless you're debugging
    // prefs!.remove("recitation_details");
    loadPrefs();
  }

  static final RecitationDetails _recitationDetails = RecitationDetails._();

  static RecitationDetails get instance => _recitationDetails;

  Map<String, Map<String, dynamic>> details = {};
  SharedPreferences? prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  /// Toggle favorite status of a Surah
  void toggleFavorite(String reciterId) {
    loadPrefs();

    // Handle cases when reciterId doesn't exist
    if (!details.containsKey(reciterId)) {
      details[reciterId] = {"favorite": false, "downloads": {}};
    }

    // Toggle the favorite flag at index 0
    details[reciterId]!["favorite"] = !details[reciterId]!["favorite"]!;

    emit(FavoriteState());
    savePrefs();
  }

  List<Reciter> getFavorites({int? id}) {
    List<Reciter> favoritesList = [];

    if (id != null) {
      _recitationDetails.details.forEach((reciterId, reciterData) {
        if (reciterData["favorite"]) {
          favoritesList.add(reciters[int.parse(reciterId)]!);
        }
      });
    } else {
      _recitationDetails.details.forEach((reciterId, reciterData) {
        if (reciterData["favorite"] && reciterId != id.toString()) {
          favoritesList.add(reciters[int.parse(reciterId)]!);
        }
      });
    }

    return favoritesList;
  }

  /// Toggle downloads status of a Surah
  void toggleDownload(String reciterId, String surahId) {
    loadPrefs();

    if (!details.containsKey(reciterId)) {
      details[reciterId] = {"favorite": false, "downloads": {}};
    }

    if (!details[reciterId]!["downloads"].containsKey(surahId)) {
      details[reciterId]!["downloads"][surahId] = false;
    }

    // Toggle the downloads flag at index 1
    details[reciterId]!["downloads"][surahId] =
        !details[reciterId]!["downloads"][surahId];

    emit(DownloadState());
    savePrefs();
  }

  /// Save the `details` map to SharedPreferences
  void savePrefs() async {
    if (prefs == null) await init();
    prefs?.setString("recitation_details", jsonEncode(details));
  }

  /// Load the `details` map from SharedPreferences
  void loadPrefs() async {
    if (prefs == null) await init();
    // prefs!.remove("recitation_details");

    final jsonString = prefs?.getString("recitation_details");
    if (jsonString == null) {
      details = {};
      return;
    }

    final Map<String, dynamic> decoded = jsonDecode(jsonString);

    // Convert the dynamic map back into the correct structure
    details = decoded.map<String, Map<String, dynamic>>(
      (reciterId, reciterData) => MapEntry(reciterId, {
        "favorite": reciterData["favorite"] ?? false,
        "downloads": reciterData["downloads"] ?? {},
      }),
    );
  }
}
