import 'package:flutter/material.dart';
import 'package:quiz_app/data/data.dart';
import 'package:quiz_app/QuizSummary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.selected, required this.onRestart});
  final void Function() onRestart;
  final List<String> selected;

  Map<String, dynamic> getMap() {
    final List<Map<String, dynamic>> summary = [];
    int cnt = 0;
    for (int i = 0; i < questions.length; i++) {
      if (selected[i] == questions[i].answers[0]) cnt++;
      summary.add({
        'i': i + 1,
        'q': questions[i].text,
        'a': questions[i].answers[0],
        'a2': selected[i]
      });
    }
    return {'summary': summary, 'correct': cnt};
  }

  @override
  Widget build(BuildContext context) {
    final mapp = getMap();
    final map = mapp['summary'];
    final correct = mapp['correct'];
    final textScale = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correct out of ${questions.length} questions correctly!',
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
              )),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Summary(qsummary: map),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
              onPressed: onRestart, // when pressed
              icon: const Icon(
                Icons.replay,
                color: Color.fromARGB(255, 255, 255, 255), // color for the icon
              ),
              label: const Text(
                'Restart Quiz!',
                style: TextStyle(
                  color:
                      Color.fromARGB(255, 250, 250, 250), // color for the text
                ),
              ),

              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    19, 179, 38, 210), // background color of the button
                // padding: EdgeInsets.symmetric(
                // horizontal: 16.0, vertical: 8.0), // padding
              ),
            )
          ],
        ),
      ),
    );
  }
}
