import 'package:dio/dio.dart';

class TafserServices {
  late Dio dio;

  TafserServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: "http://api.quran-tafseer.com/tafseer/1/",
    );
    dio = Dio(baseOptions);
  }

  Future<dynamic> getversetafser(int surahnumber, int versenumber) async {
    try {
      Response response = await dio.get("$surahnumber/$versenumber");
      return response.data;
    } catch (e) {
      return;
    }
  }
}
