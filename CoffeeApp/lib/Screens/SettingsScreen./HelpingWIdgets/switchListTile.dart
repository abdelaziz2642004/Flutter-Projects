import 'package:flutter/material.dart';
import 'package:prj/Models/Coffee.dart';

Widget customSwitchTile(
  bool val,
  Function(filters, bool) onChanged,
  filters filter,
) {
  return SwitchListTile(
    title: Text(filter.name),
    value: val,
    onChanged: (val) => onChanged(filter, val),
    activeColor: const Color.fromARGB(255, 175, 75, 17),
  );
}
