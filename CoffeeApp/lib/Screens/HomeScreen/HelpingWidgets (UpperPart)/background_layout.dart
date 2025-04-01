import 'package:flutter/material.dart';

class BackgroundLayout extends StatelessWidget {
  const BackgroundLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 13,
          child: Container(color: const Color(0xFF222222)), // Top half
        ),
        Expanded(
          flex: 25,
          child: Container(color: const Color(0xfff9f9f9)), // Bottom half
        ),
      ],
    );
  }
}
