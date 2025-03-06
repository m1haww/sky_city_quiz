import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/my_provider.dart';
import 'package:sky_city_quiz/pages/utils/classes.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart';

class QuizPage extends StatefulWidget {
  final int sectionIndex;

  const QuizPage({Key? key, required this.sectionIndex}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<int, String?> selectedAnswers = {};

  void _onOptionSelected(int questionIndex, String option) {
    setState(() {
      selectedAnswers[questionIndex] = option;
    });

    final question = quiz[widget.sectionIndex].questions[questionIndex];

    if (option == question['correctAnswer']) {
      print("🎯 Răspuns corect! Adăugăm monede.");
      Provider.of<MyProvider>(context, listen: false).addCoins(10);
    } else {
      print("❌ Răspuns greșit! Nu adăugăm monede.");
    }
  }

  void _onNextPressed() {
    final provider = Provider.of<MyProvider>(context, listen: false);
    final quizSection = quiz[widget.sectionIndex];
    final questions = quizSection.questions;

    if (selectedAnswers.length < questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please answer all questions!")),
      );
      return;
    }

    int coinsEarned = 0;

    // Calculate coins based on correct answers
    for (int i = 0; i < questions.length; i++) {
      if (selectedAnswers[i] == questions[i]['correctAnswer']) {
        coinsEarned += 10; // ✅ Add 10 coins for each correct answer
      }
    }

    // Update coins in Provider
    provider.addCoins(coinsEarned);

    // Show message with earned coins
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("You earned $coinsEarned coins!")),
    );

    // Move to the next section
    if (widget.sectionIndex < quiz.length - 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(sectionIndex: widget.sectionIndex + 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Quiz Completed! You have ${provider.coins} coins.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizSection = quiz[widget.sectionIndex];
    final questions = quizSection.questions;

    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(quizSection.section),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            actions: [
              Consumer<MyProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.monetization_on, color: Colors.yellow),
                        SizedBox(width: 5),
                        Text(
                          provider.coins
                              .toString(), // ✅ Display live coin count
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
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
                              children:
                                  question['options'].map<Widget>((option) {
                                final isSelected =
                                    selectedAnswers[index] == option;
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
                  child: Text(widget.sectionIndex < quiz.length - 1
                      ? "Next"
                      : "Finish"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
