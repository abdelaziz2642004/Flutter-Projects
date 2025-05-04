import 'package:flutter/material.dart';

void showSuccessPopup(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close popup
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 205, 131, 46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("OK", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
