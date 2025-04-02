import 'package:flutter/material.dart';
import 'package:quran_app/features/search/view/quran_screen.dart';
import 'package:quran_app/features/surahindex.dart';
import 'package:quran_app/core/widgets/custom_option.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Custom_option(
              title: "المصحف",
              destination: const SurahIndex(),
              child: Image.asset("assets/images/book.png"),
            ),
            const Custom_option(
              title: "البحث",
              destination: SearchScreen(),
              child: Icon(Icons.search, size: 40, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
