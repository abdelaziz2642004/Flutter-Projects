import '/Screens/EditInfoScreen/editService.dart';

import 'package:flutter/material.dart';

List<Widget> SaveButton(EditService editService, BuildContext context) {
  return [
    TextButton(
      onPressed: () {
        if (editService.formKey.currentState!.validate()) {
          editService.editStudent();
          Navigator.pop(context);
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xffc47c51),
        minimumSize: const Size(320, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: const Text(
        maxLines: 1,
        'Save',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const SizedBox(height: 12),
  ];
}
