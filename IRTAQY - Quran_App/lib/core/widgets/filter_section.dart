import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  final Color primaryColor;
  final Color accentColor;
  final String selectedReciter;
  final int selectedJuz;
  final bool showShortSurahs;
  final Function(String?) onReciterChanged;
  final Function(int?) onJuzChanged;
  final Function(bool) onLengthChanged;

  const FilterSection({
    super.key,
    required this.primaryColor,
    required this.accentColor,
    required this.selectedReciter,
    required this.selectedJuz,
    required this.showShortSurahs,
    required this.onReciterChanged,
    required this.onJuzChanged,
    required this.onLengthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filters',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                    Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: selectedReciter,
              decoration: InputDecoration(
                labelText: 'Reciter',
                labelStyle: TextStyle(
                  color:
                      Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor
                          ?.resolve({}) ??
                      Colors.blue,
                ),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.person,
                  color:
                      Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor
                          ?.resolve({}) ??
                      Colors.blue,
                ),
              ),
              dropdownColor: const Color(0xFF1E1E1E),
              style: TextStyle(
                color:
                    Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                    Colors.blue,
              ),
              onChanged: onReciterChanged,
              items:
                  ['Mishary Rashid', 'Abdul Basit']
                      .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<int>(
              value: selectedJuz,
              decoration: InputDecoration(
                labelText: 'Juz',
                labelStyle: TextStyle(
                  color:
                      Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor
                          ?.resolve({}) ??
                      Colors.blue,
                ),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.book,
                  color:
                      Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor
                          ?.resolve({}) ??
                      Colors.blue,
                ),
              ),
              dropdownColor: const Color(0xFF1E1E1E),
              style: TextStyle(
                color:
                    Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                    Colors.blue,
              ),
              onChanged: onJuzChanged,
              items:
                  List.generate(30, (index) => index + 1)
                      .map<DropdownMenuItem<int>>(
                        (int value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text('Juz $value'),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: Text(
                'Show Short Surahs Only (<150 Verses)',
                style: TextStyle(
                  color:
                      Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.backgroundColor
                          ?.resolve({}) ??
                      Colors.blue,
                ),
              ),
              activeColor:
                  Theme.of(
                    context,
                  ).elevatedButtonTheme.style?.backgroundColor?.resolve({}) ??
                  Colors.blue,
              value: showShortSurahs,
              onChanged: onLengthChanged,
            ),
          ],
        ),
      ),
    );
  }
}
