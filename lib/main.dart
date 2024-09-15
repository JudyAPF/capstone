import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/firebase_options.dart';
import 'package:ibenture/provider/company_provider.dart';
import 'package:ibenture/provider/edit_image_provider.dart';
import 'package:ibenture/provider/execution_provider.dart';
import 'package:ibenture/provider/executive_summary_provider.dart';
import 'package:ibenture/provider/financial_plan_provider.dart';
import 'package:ibenture/provider/front_page_provider.dart';
import 'package:ibenture/provider/opportunity_provider%20.dart';
import 'package:ibenture/provider/welcome_provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:ibenture/screens/walkscreen/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(IBenture());
}

class IBenture extends StatelessWidget {
  IBenture({super.key});

  final colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF311A72));

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BusinessPlanMakerProvider()),
          ChangeNotifierProvider(create: (_) => WelcomeProvider()),
          ChangeNotifierProvider(create: (_) => EditImageProvider()),
          ChangeNotifierProvider(create: (_) => FrontPageProvider()), 
          ChangeNotifierProvider(create: (_) => ExecutiveSummaryProvider()),  
          ChangeNotifierProvider(create: (_) => OpportunityProvider()),
          ChangeNotifierProvider(create: (_) => ExecutionProvider()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
          ChangeNotifierProvider(create: (_) => FinancialPlanProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData().copyWith(
            colorScheme: colorScheme,
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              displayMedium: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          home: AnimatedSplashScreen(
            backgroundColor: const Color(0xFF311A72),
            splashIconSize: 500,
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            splash: Center(child: Image.asset('assets/images/IBenture_white_logo.png')),
            nextScreen: const WelcomeScreen(),
          ),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
