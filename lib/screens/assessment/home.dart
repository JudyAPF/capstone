import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/screens/assessment/question.dart';
import 'package:ibenture/screens/business_plan_maker_feature/business_plan_maker.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

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
          fontSize: 19,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 220,
            left: 16,
            right: 16,
            child: Container(
              height: 350,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 90),
                child: Text(
                  "This assessment will consist of key questions. By answering the key questions, we'll help you assess the viability of your chosen location and equip you with valuable insights to make informed decisions.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            top: 16.0.h,
            right: 16.0.w,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BusinessPlanMakerScreen(),
                    ));
              },
              child: Text(
                'Skip',
                style: GoogleFonts.kanit(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Image.asset(
              'assets/images/intropic.png',
              height: 350,
              width: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionnaireScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6748E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
