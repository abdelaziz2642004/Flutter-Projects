import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Screens/SearchScreen/SearchScreen.dart';

class FiltersUI {
  static const Color kPrimaryColor = Color(0xFFC47C51);
  static const Color kButtonColor = Color.fromARGB(255, 196, 124, 72);
  static const Color kActiveSwitchColor = Color.fromARGB(255, 175, 75, 17);
  static const double kButtonSize = 55;
  static const double kIconSize = 28;
  static const double kBorderRadius = 14;

  final Map<filters, bool> filterStates = {
    filters.isSugary: true,
    filters.isDairy: true,
    filters.isDecaf: true,
    filters.containsNuts: true,
    filters.containsCaffeine: true,
  };

  void showFilterDialog(
    BuildContext context,
    bool fromOut,
    Function(Map<filters, bool>) filtering,
  ) {
    if (fromOut) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchScreen()),
      );
    }
    if (!fromOut) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text(
                  'Results Options',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DopisBold',
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      filters.values
                          .map(
                            (filter) => buildSwitchTile(
                              filter,
                              filterStates[filter]!,
                              (value) =>
                                  setState(() => filterStates[filter] = value),
                            ),
                          )
                          .toList(),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DopisBold',
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ).then((_) => filtering(filterStates));
    }
  }

  Widget buildSwitchTile(
    filters filter,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        filterLabel(filter),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'DopisBold',
        ),
      ),
      value: value,
      activeColor: kActiveSwitchColor,
      onChanged: onChanged,
    );
  }

  String filterLabel(filters filter) {
    switch (filter) {
      case filters.isSugary:
        return 'Sugary';
      case filters.isDairy:
        return 'Dairy';
      case filters.isDecaf:
        return 'Decaf';
      case filters.containsNuts:
        return 'Contains Nuts';
      case filters.containsCaffeine:
        return 'Contains Caffeine';
    }
  }
}
