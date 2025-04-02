import 'package:quran_app/features/search/data/models/index_model.dart';

abstract class SearchState{

}
class InitialState extends SearchState{

}
class LoadingState extends SearchState{

}
class LoadedState extends SearchState{
  List<SurahVerse> allverse;
  LoadedState(this.allverse);
}