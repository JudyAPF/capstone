// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibenture/models/lesson_model.dart';
import 'package:ibenture/screens/educational_modules/moduleHome.dart';

class ExamScreen extends StatefulWidget {
  final List<ExamQuestions> examQuestions;

  const ExamScreen({required this.examQuestions, super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final Map<int, String?> _answers = {};
  int? _score;
  bool _showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Lesson 1 Quiz'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: _score == null
            ? ListView.builder(
                itemCount: widget.examQuestions.length,
                itemBuilder: (context, index) {
                  final question = widget.examQuestions[index];
                  return _buildQuestionCard(index, question);
                },
              )
            : _buildAnswersView(),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _score == null ? _submitExam : _closeExam,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            _score == null ? 'Submit' : 'Close',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(int index, ExamQuestions question) {
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
              'Question ${index + 1}/${widget.examQuestions.length}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              question.examquestion ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
            Column(
              children: question.examoptions!.map((option) {
                final isSelected = _answers[index] == option;
                final isCorrect = question.examanswer == option;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.blueAccent, // Consistent border color
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
      itemCount: widget.examQuestions.length,
      itemBuilder: (context, index) {
        final question = widget.examQuestions[index];
        final userAnswer = _answers[index];
        final correctAnswer = question.examanswer;

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
                  question.examquestion ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Changed to black
                  ),
                ),
                const SizedBox(height: 10),
                // Null check for examoptions
                if (question.examoptions != null)
                  Column(
                    children: question.examoptions!.map((option) {
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

  void _submitExam() async {
    if (_answers.length != widget.examQuestions.length) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please answer all questions before submitting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    int score = 0;

    for (int i = 0; i < widget.examQuestions.length; i++) {
      final question = widget.examQuestions[i];
      if (_answers[i] == question.examanswer) {
        score++;
      }
    }

    setState(() {
      _score = score;
      _showAnswers = true;
    });

    await _updateUserProgress(score);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exam Result'),
          content: Text(
              'Your score is $_score out of ${widget.examQuestions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _showAnswers = true;
                });
              },
              child: const Text('View Answers'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ModuleHomeScreen()),
                );
              },
              child: const Text('Close'),
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

    Map<String, dynamic> updates = {};

    if (progressSnapshot.exists) {
      int currentExamScore = progressSnapshot['ExamScore'] ?? 0;
      bool currentExamComplete = progressSnapshot['ExamComplete'] ?? false;

      if (score > currentExamScore) {
        updates['ExamScore'] = score;
      }

      if (score >= 20) {
        if (!currentExamComplete) {
          updates['ExamComplete'] = true;
        }
      }
    } else {
      updates = {
        'ExamScore': score,
        'ExamComplete': score >= 20,
      };
    }

    if (updates.isNotEmpty) {
      try {
        await progressDocRef.update(updates);
      } catch (e) {
        print("Error updating document: $e");
      }
    }
  }

  void _closeExam() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ModuleHomeScreen()),
    );
  }
}
