import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/Models/Surah.dart';

final selectedSurahProvider = StateProvider<Surah?>((ref) => null);
