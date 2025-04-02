import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/features/search/data/repo/search_repo.dart';
import 'package:quran_app/features/search/data/services/surah_frombakige.dart';
import 'package:quran_app/features/search/view_model/search_block.dart';
import 'package:quran_app/features/search/view_model/search_state.dart';
import 'package:quran_app/features/surah.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SearchBloce(searchRepo: SearchRepo(SurahformBakige())),
      child: const SearchBlocConsumer(),
    );
  }
}

class SearchBlocConsumer extends StatelessWidget {
  const SearchBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بحث في الآيات')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'ابحث عن جزء من آية',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (query) {
                BlocProvider.of<SearchBloce>(context).search(query);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloce, SearchState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedState) {
                  return state.allverse.isEmpty
                      ? const Center(child: Text('لا توجد نتائج'))
                      : ListView.builder(
                        itemCount: state.allverse.length,
                        itemBuilder: (context, index) {
                          var item = state.allverse[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder:
                                      (context) => SurahViewScreen(
                                        surahNumber: item.surahNumber,
                                        verseNumber: item.verseNumber,
                                      ),
                                ),
                              );
                            },
                            title: Text(
                              item.verseText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Traditional Arabic',
                              ),
                            ),
                            subtitle: Text(
                              'سورة ${item.surahName} - آية ${item.verseNumber}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          );
                        },
                      );
                } else {
                  return const Center(child: Text('حدث خطأ غير متوقع'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
