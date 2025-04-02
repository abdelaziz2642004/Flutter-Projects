class Surahh {
  final String name;
  final String reciter;

  Surahh({required this.name, required this.reciter});

  // Optional: Factory method for JSON or database integration later
  factory Surahh.fromJson(Map<String, dynamic> json) {
    return Surahh(
      name: json['surah'] as String,
      reciter: json['reciter'] as String,
    );
  }

  // Optional: Convert back to map if needed
  Map<String, String> toMap() {
    return {'surah': name, 'reciter': reciter};
  }
}
