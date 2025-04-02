import 'package:flutter/material.dart';
import 'package:quran_app/core/widgets/filter_section.dart';
import 'package:quran_app/core/widgets/surah_list.dart';
import 'package:quran_app/features/recitation/view_model/recitation_view_model.dart';

class Recitation extends StatefulWidget {
  const Recitation({super.key});

  @override
  State<Recitation> createState() => _RecitationState();
}

class _RecitationState extends State<Recitation>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final RecitationViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = RecitationViewModel();
    _viewModel.filterSurahs(); // Initial filtering
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Column(
        children: [
          FilterSection(
            primaryColor:
                Theme.of(context).appBarTheme.backgroundColor ??
                const Color(0xFF1A237E),
            accentColor:
                Theme.of(
                  context,
                ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                const Color(0xFFBBDEFB),
            selectedReciter: _viewModel.selectedReciter,
            selectedJuz: _viewModel.selectedJuz,
            showShortSurahs: _viewModel.showShortSurahs,
            onReciterChanged: (newValue) {
              setState(() {
                _viewModel.updateReciter(newValue!);
              });
            },
            onJuzChanged: (newValue) {
              setState(() {
                _viewModel.updateJuz(newValue!);
              });
            },
            onLengthChanged: (newValue) {
              setState(() {
                _viewModel.updateLengthFilter(newValue);
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SurahList(
              filteredSurahs: _viewModel.filteredSurahs,
              onSurahTap: _viewModel.playSurah,
            ),
          ),
        ],
      ),
    );
  }
}
