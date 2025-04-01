import 'package:flutter/material.dart';
import 'package:quiz_app/data/data.dart';
import 'package:quiz_app/AnswerButton.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});
  final void Function(String answer) onSelectAnswer;
  @override
  State<QuestionsScreen> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int index = 0;

  void choose(String selectedA) {
    widget.onSelectAnswer(
        selectedA); // add it here so everytime we move to a different page , an answer is added
    setState(() {
      // and change the state of the current page so it changes the display to another question
      index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 100, // Set a fixed height for the question text
              child: Text(
                questions[index].text,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Add spacing between each answer button
            ...questions[index].getShufflesAnswers().map(
              (item) {
                return Padding(
                  padding: const EdgeInsets.only(
                      bottom: 10.0), // Space between answers
                  child: SizedBox(
                    width:
                        double.infinity, // Ensure the button takes full width
                    child: AnswerButton(
                      text: item,
                      nextindex: () {
                        // NOTICE THIS IS GENIOUS
                        choose(item);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
