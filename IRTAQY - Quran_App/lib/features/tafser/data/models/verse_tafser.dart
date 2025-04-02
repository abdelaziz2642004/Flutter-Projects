class VerseTafser {
  int? tafseerId;
  String? tafseerName;
  String? ayahUrl;
  int? ayahNumber;
  String? text;

  VerseTafser({
    this.tafseerId,
    this.tafseerName,
    this.ayahUrl,
    this.ayahNumber,
    this.text,
  });

  VerseTafser.fromJson(Map<String, dynamic> json) {
    tafseerId = json['tafseer_id'];
    tafseerName = json['tafseer_name'];
    ayahUrl = json['ayah_url'];
    ayahNumber = json['ayah_number'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tafseer_id'] = tafseerId;
    data['tafseer_name'] = tafseerName;
    data['ayah_url'] = ayahUrl;
    data['ayah_number'] = ayahNumber;
    data['text'] = text;
    return data;
  }
}
