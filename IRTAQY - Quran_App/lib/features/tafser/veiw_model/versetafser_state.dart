import '../data/models/verse_tafser.dart';

abstract class VerseTafserState{}
class InitialTafserState extends VerseTafserState{}
class LoadingTafserState extends VerseTafserState{}
class LoadedTafserState extends VerseTafserState{
  final VerseTafser verseTafser;
  LoadedTafserState(this.verseTafser);
}