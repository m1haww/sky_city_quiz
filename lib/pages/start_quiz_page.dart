import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_city_quiz/pages/my_provider.dart';
import 'package:sky_city_quiz/pages/quiz_page.dart';
import 'package:sky_city_quiz/pages/utils/containers.dart'; // Make sure to import your QuizPage

class StartQuizPage extends StatelessWidget {
  const StartQuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildBackground(context),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: const Text(
              'Quiz',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 40,
                  fontFamily: "Ingrid"),
            ),
            elevation: 0,
            actions: [
              Consumer<MyProvider>(
                builder: (context, provider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("images/Group 19.png"),
                          height: 25,
                        ),
                        SizedBox(width: 5),
                        Text(provider.coins.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xffFFB22C),
                            )),
                      ],
                    ),
                  );
                },
              ),
            ],
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
                style: TextStyle(
                    fontSize: 25, color: Colors.white, fontFamily: "Inria"),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 45, 41, 41),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
