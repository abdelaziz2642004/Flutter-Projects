import 'package:flutter/material.dart';

class SurahList extends StatelessWidget {
  final List<Map<String, dynamic>> filteredSurahs;
  final Function(String) onSurahTap;

  const SurahList({
    super.key,
    required this.filteredSurahs,
    required this.onSurahTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredSurahs.length,
      itemBuilder: (context, index) {
        final surah = filteredSurahs[index];
        return Card(
          color: const Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            leading: Icon(
              Icons.book,
              color:
                  Theme.of(
                    context,
                  ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                  Colors.blue,
            ),
            title: Text(
              surah['name']!,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            subtitle: Text(
              surah['transliteration']!,
              style: TextStyle(color: Colors.grey[400]),
            ),
            trailing: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: surah['progress'],
                backgroundColor: Colors.grey[700],
                color:
                    Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                    Colors.blue,
                strokeWidth: 3,
              ),
            ),
            onTap: () => onSurahTap(surah['name']!),
          ),
        );
      },
    );
  }
}
