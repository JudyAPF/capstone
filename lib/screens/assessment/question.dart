// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:ibenture/screens/assessment/result.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int currentStep = 0;
  List<double> scores = List.filled(10, 0.0);
  Map<int, bool> yesNoResponses = {}; 
  bool _isLoading = false; 

  List<Map<String, dynamic>> questions = [
    {"question": "Which specific location do you want to assess?", "type": "text"},
    {"question": "Is the area heavily populated?", "type": "yesno"},
    {"question": "On a scale of 1 to 5, with 1 being the lowest and 5 being the highest, how large is the area's population?", "type": "scale"},
    {"question": "Do you believe there is an unmet need for your product/service in this area?", "type": "yesno"},
    {"question": "On a scale of 1 to 5, with 1 being the lowest and 5 being the highest. How close is the location to key suppliers and vendors?", "type": "scale"},
    {"question": "Is the location accessible by car, public transport, or walking?", "type": "yesno"},
    {"question": "Is there enough foot traffic for your business?", "type": "yesno"},
    {"question": "Are there existing competitors in the area?", "type": "yesno"},
    {"question": "On a scale of 1 to 5, with 1 being the lowest and 5 being the highest., how established is the competition in the area?", "type": "scale"},
    {"question": "Do you know the strengths and weaknesses of your competitors in this area?", "type": "yesno"}
  ];

  double _calculateTotalScore() {
    return scores.reduce((a, b) => a + b) / questions.length;
  }

  void _handleNext() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    double totalScore = _calculateTotalScore();
    Navigator.push(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(totalScore: totalScore),
      ),
    ).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF3A0F83),
        title: const Text('Location Suitability Assessment'),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(questions.length, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: index == currentStep ? const Color(0xFF6748E5) : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 30),

                // Question Header
                Center(
                  child: Text(
                    "Question ${currentStep + 1} of ${questions.length}",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        questions[currentStep]['question'],
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      
                      if (questions[currentStep]['type'] == 'text') 
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Please type here',
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),

                      if (questions[currentStep]['type'] == 'yesno') 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: yesNoResponses[currentStep] ?? false,
                                    onChanged: (value) {
                                      setState(() {
                                        yesNoResponses[currentStep] = value!;
                                        scores[currentStep] = value ? 100.0 : 25.0;
                                      });
                                    },
                                  ),
                                  const Text("Yes"),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: yesNoResponses[currentStep] == false,
                                    onChanged: (value) {
                                      setState(() {
                                        yesNoResponses[currentStep] = value == false;
                                        scores[currentStep] = value == false ? 25.0 : 100.0;
                                      });
                                    },
                                  ),
                                  const Text("No"),
                                ],
                              ),
                            ),
                          ],
                        ),

                      if (questions[currentStep]['type'] == 'scale') 
                        Column(
                          children: List.generate(5, (index) {
                            int value = index + 1;
                            return ListTile(
                              title: Text('$value'),
                              leading: Radio<double>(
                                value: value * 20.0,
                                groupValue: scores[currentStep],
                                onChanged: (value) {
                                  setState(() {
                                    scores[currentStep] = value!;
                                  });
                                },
                              ),
                            );
                          }),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (currentStep < questions.length - 1) {
                        setState(() {
                          currentStep++;
                        });
                      } else {
                        _handleNext(); 
                      }
                    },
                    // ignore: sort_child_properties_last
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: const Color(0xFF6748E5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
