import 'package:flutter/material.dart';
import 'package:sky_city_quiz/pages/quiz_page.dart'; // Make sure to import your QuizPage

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the QuizPage, starting from sectionIndex 0
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPage(
                    sectionIndex: 0), // Start quiz from the first section
              ),
            );
          },
          child: const Text(
            'Start Quiz',
            style: TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Button background color
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
