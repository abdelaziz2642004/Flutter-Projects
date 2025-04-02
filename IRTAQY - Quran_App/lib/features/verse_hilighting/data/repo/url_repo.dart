import 'package:quran/quran.dart' as quran;
import 'package:quran_app/features/verse_hilighting/data/services/get_verse_url.dart';

class VerseUrlRepo {
  final GetVerseUrl getVerseUrl;

  VerseUrlRepo(this.getVerseUrl);

  Future<List<String>> prepareAudioUrls(int surahNumber) async {
    List<String> audioUrls = [];
    getVerseUrl.downloadSurah(surahNumber);
    audioUrls = await Future.wait(
      List.generate(quran.getVerseCount(surahNumber), (index) async {
        final localPath = await getVerseUrl.getLocalPath(
          surahNumber,
          index + 1,
        );
        return localPath; // Use local file
      }),
    );
    return audioUrls;
  }
}
