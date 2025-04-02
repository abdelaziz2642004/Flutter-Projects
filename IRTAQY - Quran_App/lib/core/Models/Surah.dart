class Surah {
  final int id;
  final String revelationPlace;
  final int revelationOrder;
  final bool bismillahPre;
  final String nameSimple;
  final String nameComplex;
  final String nameArabic;
  final int versesCount;
  final List<int> pages;
  String audioUrl = "";

  Surah({
    required this.id,
    required this.revelationPlace,
    required this.revelationOrder,
    required this.bismillahPre,
    required this.nameSimple,
    required this.nameComplex,
    required this.nameArabic,
    required this.versesCount,
    required this.pages,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: int.parse(json['id'].toString()),
      revelationPlace: json['revelation_place'] ?? "",
      revelationOrder: json['revelation_order'] ?? 0,
      bismillahPre: json['bismillah_pre'] ?? true,
      nameSimple: json['name_simple'] ?? "",
      nameComplex: json['name_complex'] ?? "",
      nameArabic: json['name_arabic'] ?? "",
      versesCount:
          (json["verses_count"] is String
              ? int.parse(json['verses_count'])
              : json['verses_count']) ??
          0,
      pages: List<int>.from(json['pages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "revelation_place": revelationPlace,
      "revelation_order": revelationOrder,
      "bismillah_pre": bismillahPre,
      "name_simple": nameSimple,
      "name_complex": nameComplex,
      "name_arabic": nameArabic,
      "verses_count": versesCount.toString(),
      "pages": pages,
    };
    /*Surah(

    );*/

    // return Surah(
    //   id: 1,
    //   revelationPlace: 'ff',
    //   revelationOrder: 2,
    //   bismillahPre: true,
    //   nameSimple: 'sg',
    //   nameComplex: 'gdg',
    //   nameArabic: 'sg',
    //   versesCount: 4,
    //   pages: [1, 2],
    //   translatedName: 'GGDF',
    //   audioUrl: audioUrl,
    // );
  }
}
