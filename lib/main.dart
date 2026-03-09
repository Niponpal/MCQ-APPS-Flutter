import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MCQ Quiz",
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int selectedIndex = -1;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "What is the capital of Bangladesh?",
      "options": ["Chittagong", "Khulna", "Dhaka", "Sylhet"],
      "answer": 2,
    },
    {
      "question": "Which language is used in Flutter?",
      "options": ["Java", "Dart", "Python", "C#"],
      "answer": 1,
    },
    {
      "question": "Who developed Flutter?",
      "options": ["Apple", "Microsoft", "Google", "Facebook"],
      "answer": 2,
    },
    {
      "question": "Which widget is used for layout in Flutter?",
      "options": ["Column", "Database", "File", "Console"],
      "answer": 0,
    },
  ];

  void checkAnswer(int index) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedIndex = index;
      if (index == questions[currentQuestion]['answer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      answered = false;
      selectedIndex = -1;
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        currentQuestion = questions.length;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      answered = false;
      selectedIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestion >= questions.length) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        body: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Quiz Finished 🎉",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Your Score: $score / ${questions.length}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: restartQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Restart Quiz",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final question = questions[currentQuestion];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("MCQ Quiz App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Score: $score",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  ...List.generate(question['options'].length, (index) {
                    Color bgColor = Colors.blue.shade600;
                    Color textColor = Colors.white;

                    if (answered) {
                      if (index == question['answer']) {
                        bgColor = Colors.green.shade600;
                      } else if (index == selectedIndex) {
                        bgColor = Colors.red.shade600;
                      }
                    }

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        onPressed: () => checkAnswer(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bgColor,
                          foregroundColor: textColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: answered ? 2 : 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          question['options'][index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 30),

                  if (answered)
                    ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Next Question",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
