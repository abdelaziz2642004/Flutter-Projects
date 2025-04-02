class AudioFile {
  final int surahNumber;
  final String audioUrl;

  AudioFile({required this.surahNumber, required this.audioUrl});

  factory AudioFile.fromJson(Map<String, dynamic> json) {
    return AudioFile(
      surahNumber: json['chapter_id'],
      audioUrl: json['audio_url'],
    );
  }
}
