class AyahRecitation {
  final String verseKey; // Example: "99:1" (Surah:Verse)
  final String audioUrl; // The URL for the audio file

  AyahRecitation({required this.verseKey, required this.audioUrl});

  factory AyahRecitation.fromJson(Map<String, dynamic> json) {
    return AyahRecitation(verseKey: json['verse_key'], audioUrl: json['url']);
  }
}
