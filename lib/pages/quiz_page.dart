import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/my_provider.dart'; // Assuming you have this provider
import 'package:sky_city_quiz/pages/utils/classes.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart'; // Assuming quiz data is here

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

    // Show the total coins in a ScaffoldMessenger
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Total Coins: ${provider.coins}'),
      ),
    );

    if (widget.sectionIndex < quiz.length - 1) {
      // Navigate to the next quiz section
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(sectionIndex: widget.sectionIndex + 1),
        ),
      );
    } else {
      // If quiz is finished, show the finish dialog
      _showFinishDialog(coinsEarned, provider);
    }
  }

  void _showFinishDialog(int coinsEarned, MyProvider provider) {
    final height = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            "Quiz Completed!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontFamily: "Ingrid"),
          ),
          content: SizedBox(
            height: height * 0.05, // Smaller height
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("images/Group 19.png"), height: 25),
                    buildWidth(context, 0.01),
                    Text(
                      "${provider.coins}",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Imprima",
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            SizedBox(
              width: 100, // Make button smaller
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
                child: Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14, // Smaller font
                    fontFamily: "Imprima",
                  ),
                ),
              ),
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

    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              quizSection.section,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  fontFamily: "Ingrid"),
            ),
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
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
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
                                  title: Text(
                                    option,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: "Imprima"),
                                  ),
                                  tileColor:
                                      isSelected ? Color(0xffFFB22C) : null,
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
                    widget.sectionIndex < quiz.length - 1 ? "Next" : "Finish",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
