import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/search/data/models/index_model.dart';
import 'package:quran_app/features/search/data/repo/search_repo.dart';
import 'package:quran_app/features/search/view_model/search_state.dart';

class SearchBloce extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchBloce({required this.searchRepo}) : super(InitialState());
  Future<void> search(String query) async {
    emit(LoadingState());
    List<SurahVerse> allverse = await searchRepo.filterResults(query);
    emit(LoadedState(allverse));
  }
}
