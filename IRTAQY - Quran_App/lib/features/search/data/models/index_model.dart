class SurahVerse {
  final int surahNumber;
  final String surahName;
  final int verseNumber;
  final String verseText;
  final String normalizedText;

  SurahVerse({
    required this.surahNumber,
    required this.surahName,
    required this.verseNumber,
    required this.verseText,
    required this.normalizedText,
  });

  // Convert to Map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      'surahNumber': surahNumber,
      'surahName': surahName,
      'verseNumber': verseNumber,
      'verseText': verseText,
      'normalizedText': normalizedText,
    };
  }

  // Convert from Map when loading from Hive
  factory SurahVerse.fromMap(Map<String, dynamic> map) {
    return SurahVerse(
      surahNumber: map['surahNumber'],
      surahName: map['surahName'],
      verseNumber: map['verseNumber'],
      verseText: map['verseText'],
      normalizedText: map['normalizedText'],
    );
  }
}
