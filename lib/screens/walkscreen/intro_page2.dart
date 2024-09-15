import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/provider/welcome_provider.dart';
import 'package:provider/provider.dart';

class IntroPage2Screen extends StatelessWidget {
  const IntroPage2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final welcomeProvider = Provider.of<WelcomeProvider>(context, listen: false);

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
              'assets/images/business_plan_maker_intro.png',
              width: 300.w,
              height: 300.h,
            ),
            Text(
              'Business Plan Maker',
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
                'Plan your business effortlessly with our app. Simplify your journey from idea to success.',
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  welcomeProvider.controller.nextPage(
                      duration: const Duration(
                        microseconds: 500,
                      ),
                      curve: Curves.easeIn);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF311A72),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                ),
                child: Text(
                  'Next',
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