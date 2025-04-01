import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String text;

  const AnswerButton({super.key, required this.text, required this.nextindex});
  final void Function() nextindex;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: nextindex,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50.0), // Set fixed height
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: const Color.fromARGB(61, 42, 0, 67),
        foregroundColor: const Color.fromARGB(255, 202, 171, 254),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
