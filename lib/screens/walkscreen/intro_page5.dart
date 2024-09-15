import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/screens/login.dart';

class IntroPage5Screen extends StatelessWidget {
  const IntroPage5Screen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFF311A72)])),
        child: Column(
          children: [
            Gap(50.h),
            Image.asset(
              'assets/images/ai_chatbot.png',
              width: 300.w,
              height: 300.h,
            ),
            Text(
              'AI Chatbot',
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                fontSize: 30.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Chat effortlessly with our AI chatbot. It simplifies your interactions and provides instant support.',
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF311A72),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.kanit(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
