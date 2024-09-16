import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:ibenture/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibenture/screens/home.dart';
import 'package:ibenture/screens/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  void togglePassword() {
    obscureText = !obscureText;
    setState(() {});
  }

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    EasyLoading.show(status: 'Logging in...');

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      EasyLoading.dismiss();
      // Navigate to HomeScreen if login is successful
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          maintainState: false,
        ),
      );
    } catch (error) {
      // Handle login errors
      EasyLoading.dismiss();
      await QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: QuickAlertType.error,
        title: "Error",
        text: "Incorrect email and/or password.",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Check if user is already signed in
    if (FirebaseAuth.instance.currentUser != null) {
      // Schedule navigation to HomeScreen after build phase is complete
      Future.delayed(Duration.zero, () {
        // ignore: use_build_context_synchronously
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
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/IBenture.png',
                  height: 200.h,
                  width: 200.w,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(21.w, 29.h, 21.w, 27.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x3f000000),
                        offset: const Offset(0, 2),
                        blurRadius: 2.r,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
                  child: Column(
                    children: [
                      Text(
                        'Log In',
                        style: loginRegisterStyle,
                      ),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: smallText,
                            ),
                            Center(
                              child: TextFormField(
                                controller: emailController,
                                style: inputText,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8a8a8a)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email address.';
                                  }
                                  if (!EmailValidator.validate(value)) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Gap(10.h),
                            Text(
                              'Password',
                              style: smallText,
                            ),
                            Center(
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: obscureText,
                                style: inputText,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xff8a8a8a)),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      togglePassword();
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password.';
                                  }
                                  return null;
                                  // if (!passwordRegExp.hasMatch(value)) {
                                  //   return 'At least 1 uppercase,\n 1 lowercase, 1 digit, 1 special character,\n and be between 12 and 20 characters in length.';
                                  // }
                                },
                              ),
                            ),
                            Gap(10.h),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  height: -1.5.h,
                                  color: const Color(0xff311A72),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                login();
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    login();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: const Color(0xff311A72),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                    minimumSize: Size(double.infinity.w, 48.h),
                                  ),
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: loginRegisterButtonStyle,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Need an account?',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    height: -0.05.h,
                                    color: const Color(0xff311A72),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700,
                                      height: -0.05.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
