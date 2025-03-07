import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/my_provider.dart'; // Assuming you have this provider
import 'package:sky_city_quiz/pages/utils/classes.dart'; // Assuming quiz data is here

class QuizPage extends StatefulWidget {
  final int sectionIndex;

  const QuizPage({Key? key, required this.sectionIndex}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<int, String?> selectedAnswers = {};

  // This method updates the answer and adds coins for a correct answer
  void _onOptionSelected(int questionIndex, String option) {
    setState(() {
      selectedAnswers[questionIndex] = option;
    });

    final question = quiz[widget.sectionIndex].questions[questionIndex];

    if (option == question['answer']) {
      print("🎯 Răspuns corect! Adăugăm monede.");
      Provider.of<MyProvider>(context, listen: false).addCoins(50);
    } else {
      print("❌ Răspuns greșit! Nu adăugăm monede.");
    }
  }

  // This method handles the logic when the user presses "Next" or "Finish"
  void _onNextPressed() {
    final provider = Provider.of<MyProvider>(context, listen: false);
    final quizSection = quiz[widget.sectionIndex];
    final questions = quizSection.questions;

    if (selectedAnswers.length < questions.length) {
      return; // If not all questions are answered, do nothing
    }

    int coinsEarned = 0;

    // Calculate the total coins earned based on correct answers
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correctAnswer']) {
        coinsEarned += 50;
      }
    }

    provider.addCoins(coinsEarned);

    if (widget.sectionIndex < quiz.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(sectionIndex: widget.sectionIndex + 1),
        ),
      );
    } else {
      _showFinishDialog(coinsEarned, provider);
    }
  }

  void _showFinishDialog(int coinsEarned, MyProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Quiz Completed!"),
          content: Text(
              "You earned $coinsEarned coins.\nTotal Coins: ${provider.coins}"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizSection = quiz[widget.sectionIndex];
    final questions = quizSection.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text(quizSection.section),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: questions.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question['question'],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ListTileTheme(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: question['options'].map<Widget>((option) {
                            final isSelected = selectedAnswers[index] == option;
                            return ListTile(
                              title: Text(option),
                              tileColor: isSelected ? Colors.amber : null,
                              onTap: () => _onOptionSelected(index, option),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _onNextPressed,
              child: Text(
                  widget.sectionIndex < quiz.length - 1 ? "Next" : "Finish"),
            ),
          ],
        ),
      ),
    );
  }
}
