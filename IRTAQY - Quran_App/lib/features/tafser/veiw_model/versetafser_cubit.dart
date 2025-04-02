import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/tafser/data/models/verse_tafser.dart';
import 'package:quran_app/features/tafser/data/repo/verseetafser_repo.dart';
import 'package:quran_app/features/tafser/veiw_model/versetafser_state.dart';

class VerseTafserCubit extends Cubit<VerseTafserState> {
  final VerseTafsirRepo verseTafsirRepo;

  VerseTafserCubit({required this.verseTafsirRepo})
    : super(InitialTafserState());

  Future<void> getversetafser(int surahnumber, int versenumber) async {
    emit(LoadingTafserState());
    VerseTafser verseTafser = await verseTafsirRepo.getversetafser(
      surahnumber,
      versenumber,
    );
    emit(LoadedTafserState(verseTafser));
  }
}
