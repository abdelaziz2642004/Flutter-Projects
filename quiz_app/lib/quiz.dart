import 'package:flutter/material.dart';
import 'package:quiz_app/data/data.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/resultsScreen.dart';

import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  int activeScreen = 1;

  void switchScreen() {
    setState(() {
      activeScreen = activeScreen == 1 ? 2 : 1;
    });
  }

  List<String> selected = [];

  void chooseAnswer(String answer) {
    selected.add(answer);
    if (selected.length == questions.length) {
      setState(() {
        activeScreen = 3;
      });
    }
  }

  Widget which() {
    if (activeScreen == 1) {
      return StartScreen(switchScreen);
    } else if (activeScreen == 2) {
      return QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 3) {
      return ResultsScreen(
        selected: selected,
        onRestart: restartQuiz,
      );
    }
    return Container();
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 1; // New state for restart
      selected = [];
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: which()),
      ),
    );
  }
}
