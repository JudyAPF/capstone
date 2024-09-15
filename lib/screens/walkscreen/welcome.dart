import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/provider/welcome_provider.dart';
import 'package:ibenture/screens/home.dart';
import 'package:ibenture/screens/walkscreen/intro_page1.dart';
import 'package:ibenture/screens/walkscreen/intro_page2.dart';
import 'package:ibenture/screens/walkscreen/intro_page3.dart';
import 'package:ibenture/screens/walkscreen/intro_page4.dart';
import 'package:ibenture/screens/walkscreen/intro_page5.dart';
import 'package:ibenture/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //controller for the page view

  @override
  void initState() {
    super.initState();
    // Check if user is already signed in
    if (FirebaseAuth.instance.currentUser != null) {
      // Schedule navigation to HomeScreen after build phase is complete
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final welcomeProvider =
        Provider.of<WelcomeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: welcomeProvider.controller,
              children: const [
                IntroPage1Screen(),
                IntroPage2Screen(),
                IntroPage3Screen(),
                IntroPage4Screen(),
                IntroPage5Screen(),
              ],
            ),
            Container(
              alignment:  const Alignment(0, 0.75),
              child: SmoothPageIndicator(
                controller: welcomeProvider.controller,
                count: 5,
                effect: const WormEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
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
                        builder: (context) => const LoginScreen(),
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
          ],
        ),
      ),
    );
  }
}
