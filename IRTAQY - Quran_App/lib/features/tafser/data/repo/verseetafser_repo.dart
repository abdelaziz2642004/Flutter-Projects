import 'package:quran_app/features/tafser/data/models/verse_tafser.dart';
import 'package:quran_app/features/tafser/data/sevices/tafser_servces.dart';

class VerseTafsirRepo{
  final TafserServices tafserServices;
  VerseTafsirRepo(this.tafserServices);
  Future<VerseTafser>getversetafser(int surahnumber,int versenumber)async{
    final versetafser = await tafserServices.getversetafser(surahnumber, versenumber);
    return VerseTafser.fromJson(versetafser);
  }
}