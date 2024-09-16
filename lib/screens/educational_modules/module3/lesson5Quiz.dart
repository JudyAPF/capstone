// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibenture/models/lesson_model.dart';
import 'package:ibenture/screens/educational_modules/moduleHome.dart';

class QuizScreen5 extends StatefulWidget {
  final List<QuizQuestion> quizQuestions;

  const QuizScreen5({required this.quizQuestions, super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen5> {
  final Map<int, String?> _answers = {};
  int? _score;
  bool _showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Lesson 5 Quiz'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: _score == null
            ? ListView.builder(
                itemCount: widget.quizQuestions.length,
                itemBuilder: (context, index) {
                  final question = widget.quizQuestions[index];
                  return _buildQuestionCard(index, question);
                },
              )
            : _buildAnswersView(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _score == null ? _submitQuiz : _closeQuiz,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: Text(
            _score == null ? 'Submit' : 'Close',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, QuizQuestion question) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${index + 1}/${widget.quizQuestions.length}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              question.question,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            Column(
              children: question.options!.map((option) {
                final isSelected = _answers[index] == option;
                final isCorrect = question.answer == option;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color:
                          Colors.blue.shade300, // Keep border color consistent
                      width: 1,
                    ),
                    color: _showAnswers
                        ? (isCorrect
                            ? Colors.green.shade100
                            : isSelected
                                ? Colors.red.shade100
                                : Colors.white)
                        : Colors.white,
                  ),
                  child: RadioListTile<String>(
                    activeColor: Colors.blue,
                    title: Row(
                      children: [
                        Expanded(child: Text(option)),
                        if (_showAnswers && isSelected)
                          Icon(
                            isCorrect ? Icons.check : Icons.close,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                      ],
                    ),
                    value: option,
                    groupValue: _answers[index],
                    onChanged: (value) {
                      setState(() {
                        _answers[index] = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswersView() {
    return ListView.builder(
      itemCount: widget.quizQuestions.length,
      itemBuilder: (context, index) {
        final question = widget.quizQuestions[index];
        final userAnswer = _answers[index];
        final correctAnswer = question.answer;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Changed to black
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: question.options!.map((option) {
                    final isSelected = userAnswer == option;
                    final isCorrect = correctAnswer == option;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors
                              .blue.shade300, // Keep border color unchanged
                          width: 1,
                        ),
                        color: _showAnswers
                            ? (isCorrect
                                ? Colors.green.shade100
                                : isSelected
                                    ? Colors.red.shade100
                                    : Colors.white)
                            : Colors.white,
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Text(option)),
                            if (_showAnswers && isSelected)
                              Icon(
                                isCorrect ? Icons.check : Icons.close,
                                color: isCorrect ? Colors.green : Colors.red,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _closeQuiz() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModuleHomeScreen()),
    );
  }

  void _submitQuiz() async {
    if (_answers.length != widget.quizQuestions.length) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Incomplete Submission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            content: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Please ensure all questions are answered before submitting.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    int score = 0;

    for (int i = 0; i < widget.quizQuestions.length; i++) {
      final question = widget.quizQuestions[i];
      if (_answers[i] == question.answer) {
        score++;
      }
    }

    setState(() {
      _score = score;
      _showAnswers = true;
    });

    await _updateUserProgress(score); // Call the method to update progress

    _showScoreDialog(); // Call the method to show the score dialog
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Quiz Result',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Your score is $_score out of ${widget.quizQuestions.length}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _showAnswers = true;
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'View Answers',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ModuleHomeScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserProgress(int score) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      print("No user is currently signed in!");
      return;
    }

    String uid = currentUser.uid;
    DocumentReference progressDocRef =
        FirebaseFirestore.instance.collection('module3_progress').doc(uid);

    DocumentSnapshot progressSnapshot = await progressDocRef.get();

    // Create a map for updates
    Map<String, dynamic> updates = {};

    if (progressSnapshot.exists) {
      int currentLesson5Score = progressSnapshot['5Score'] ?? 0;
      bool currentLesson5Complete = progressSnapshot['5Complete'] ?? false;

      // Debugging prints
      print("Current Lesson 5 Score: $currentLesson5Score");
      print("Current Lesson 5 Complete: $currentLesson5Complete");

      // Update score if it's higher
      if (score > currentLesson5Score) {
        updates['5Score'] = score;
      }

      // Ensure 1Complete is set correctly
      if (score >= 8) {
        if (!currentLesson5Complete) {
          updates['5Complete'] = true;
          print("Setting 5Complete to true");
        }
      }

      // Update 2Start based on 1Complete and score
      bool shouldExamStart =
          progressSnapshot['5Complete'] == true && score >= 8;
      if (shouldExamStart) {
        updates['ExamStart'] = true;
        print("Setting ExamStart to true");
      }
    } else {
      // Document does not exist, create with initial values
      updates = {
        '5Complete': score >= 8,
        '5Score': score,
        'ExamStart': score >= 8,
        'ExamComplete': false,
        'ExamScore': 0,
      };

      print("Creating new document with initial values");
    }

    // Apply updates
    if (updates.isNotEmpty) {
      try {
        await progressDocRef.update(updates);
        print("Document updated with: $updates");

        await Future.delayed(const Duration(seconds: 1));
        DocumentSnapshot refreshedSnapshot = await progressDocRef.get();
        print("Refreshed Document Data: ${refreshedSnapshot.data()}");
      } catch (e) {
        print("Error updating document: $e");
      }
    }
  }
}
