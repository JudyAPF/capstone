import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ibenture/screens/login.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:ibenture/constants/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isAddressValid = false;

  Future<bool> validateAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void togglePassword() {
    obscureText = !obscureText;
    setState(() {});
  }

  final passwordRegExp = RegExp(
    r'^(?=.*[A-Z])' // Should contain at least one uppercase letter
    r'(?=.*[a-z])' // Should contain at least one lowercase letter
    r'(?=.*\d)' // Should contain at least one digit
    r'.{8,20}$', // Password length should be between 8 and 20 characters
  );

  // Register user
  void register() async {
    isAddressValid = await validateAddress(addressController.text);
    setState(() {});

    //validate
    if (!formKey.currentState!.validate()) {
      return;
    }

    // ignore: unrelated_type_equality_checks
    if (validateAddress(addressController.text) == false) {
      QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Please enter a valid address.',
      );
      return;
    }

    //confirm to the user
    QuickAlert.show(
      // ignore: use_build_context_synchronously
      context: context,
      type: QuickAlertType.confirm,
      // text: 'sample',
      title: 'Are you sure?',
      confirmBtnText: 'YES',
      cancelBtnText: 'NO',
      onConfirmBtnTap: () {
        Navigator.of(context).pop();
        registerUser();
      },
    );
  }

  void registerUser() async {
    try {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.loading,
        title: 'Loading',
        text: 'Registering your account',
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'firstname': firstnameController.text,
        'lastname': lastnameController.text,
        'email': emailController.text,
        'address': addressController.text,
      });

      QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Account created successfully',
      );

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      QuickAlert.show(
        // ignore: use_build_context_synchronously
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: e.message!,
      );
      // ignore: avoid_print
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/IBenture.png',
                      height: 150.h,
                      width: 150.w,
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
                            offset: Offset(0.w, 2.h),
                            blurRadius: 2.r,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 100.h),
                      child: Column(
                        children: [
                          Container(
                            // login
                            margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
                            child: Text(
                              'Register',
                              style: loginRegisterStyle,
                            ),
                          ),
                          Gap(20.h),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'First Name',
                                  style: smallText,
                                ),
                                Center(
                                  child: TextFormField(
                                    controller: firstnameController,
                                    style: inputText,
                                    decoration: inputDecoration,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a First Name.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Gap(10.h),
                                Text(
                                  'Last Name',
                                  style: smallText,
                                ),
                                Center(
                                  child: TextFormField(
                                    controller: lastnameController,
                                    style: inputText,
                                    decoration: inputDecoration,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a Last Name.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Gap(10.h),
                                Text(
                                  'Email',
                                  style: smallText,
                                ),
                                Center(
                                  child: TextFormField(
                                    controller: emailController,
                                    style: inputText,
                                    decoration: const InputDecoration(
                                        hintText: 'e.g. sample@gmail.com',
                                        border: OutlineInputBorder()),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email.';
                                      }
                                      if (EmailValidator.validate(value) ==
                                          false) {
                                        return 'Please enter a valid email.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Gap(10.h),
                                Text(
                                  'Address',
                                  style: smallText,
                                ),
                                Center(
                                  child: TextFormField(
                                    controller: addressController,
                                    style: inputText,
                                    decoration: const InputDecoration(
                                        hintText:
                                            'Barangay, City/Municipality, Province',
                                        border: OutlineInputBorder()),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an address.';
                                      }
                                      if (!isAddressValid) {
                                        return 'Please enter a valid address.';
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
                                      hintText: 'e.g. MyPassw0rd',
                                      border: const OutlineInputBorder(),
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
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a password.';
                                      }
                                      if (!passwordRegExp.hasMatch(value)) {
                                        return 'Use uppercase, lowercase, digit, and 8-20 \ncharacters.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Gap(20.h),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      register();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: const Color(0xff311A72),
                                      // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.r),
                                      ),
                                      minimumSize:
                                          Size(double.infinity.w, 48.h),
                                    ),
                                    child: Text(
                                      'Register',
                                      textAlign: TextAlign.center,
                                      style: loginRegisterButtonStyle,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account?',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                        height: -0.05.h,
                                        color: const Color(0xff311A72),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()),
                                        );
                                      },
                                      child: Text(
                                        'Login',
                                        style: registerTextStyle,
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
            ],
          ),
        ),
      ),
    );
  }
}
