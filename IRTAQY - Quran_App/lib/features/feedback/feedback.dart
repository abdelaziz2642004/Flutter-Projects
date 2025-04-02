import 'package:flutter/material.dart';

class Feedback_Screen extends StatelessWidget {
  const Feedback_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'We value your feedback!\nPlease share your suggestions or reviews.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
