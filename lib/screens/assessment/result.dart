import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double totalScore;

  const ResultScreen({super.key, required this.totalScore});

  String _getScoreMessage() {
    if (totalScore == 100) {
      return "Ideal for your business with no significant weaknesses.";
    } else if (totalScore >= 80) {
      return "Good suitability with some room for improvement.";
    } else if (totalScore >= 60) {
      return "Moderate suitability, consider adjustments.";
    } else {
      return "Low suitability, explore alternatives or improvements.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 58, 15, 131), 
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 58, 15, 131), 
        title: const Text('Location Suitability Assessment'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 58, 15, 131), 
            ),
          ),
          const Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Text(
              "We've analyzed your chosen location for your business and here's the result:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 250,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: Column(
                  children: [
                    Text(
                      'Based on our analysis, your average score is ${totalScore.toStringAsFixed(2)}%, which indicates ${_getScoreMessage().toLowerCase()}.',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
            Positioned(
            top: 120,
            child: Image.asset(
              'assets/images/result.png',
              width: 300, 
              height: 250, 
            ),
          ),
          Positioned(
            bottom: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6D4BF5), 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), 
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                'Done',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
