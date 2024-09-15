import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:getwidget/components/drawer/gf_drawer_header.dart';
import 'package:getwidget/components/image/gf_image_overlay.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/screens/ask_ibenture_feature/ask_ibenture.dart';
import 'package:ibenture/screens/educational_modules/moduleHome.dart';
import 'package:ibenture/screens/permits_and_licenses_feature/business_permits_and_licenses.dart';
import 'package:ibenture/screens/business_plan_maker_feature/business_plan_maker.dart';
import 'package:ibenture/screens/login.dart';
import 'package:ibenture/screens/business_model_canvas/business_model_canvas_editor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  String? firstName;
  String? lastName;
  String? address;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final userData = userDoc.data() as Map<String, dynamic>;
    setState(() {
      firstName = userData['firstname'];
      lastName = userData['lastname'];
      address = userData['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
            child: Image.asset('assets/images/logo_home.png', height: 50),
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            GFDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff311A72),
                    Color(0xff8E24AA),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const GFImageOverlay(
                    height: 100,
                    width: 100,
                    shape: BoxShape.circle,
                    image: AssetImage('assets/images/user.png'),
                    boxFit: BoxFit.fill,
                  ),
                  Gap(10.0.h),
                  Text(
                    '$firstName $lastName',
                    style: GoogleFonts.kanit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Image.asset(
                      'assets/images/business_plan_maker_icon.png',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('Business Plan Maker'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BusinessPlanMakerScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/permits_and_licenses_icon.png',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('Business Permits and Licenses'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CategoryListBusinessPermitsAndLicensesScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/ask_benture_icon.png',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('Ask Benture'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AskIBentureScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/modules/pdf.png',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('Educational Business Modules'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ModuleHomeScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/images/image_editor.png',
                      height: 32,
                      width: 32,
                    ),
                    title: const Text('Business Model Canvas Editor'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BusinessModelCanvasEditor(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: const Color(0xfff2edf8),
              leading: Image.asset(
                'assets/images/logout_icon.png',
                height: 24,
                width: 24,
              ),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Image.asset(
                'assets/images/user_home.png',
                height: 32,
                width: 32,
              ),
            ),
            title: Text(
              '$firstName $lastName',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                Text(
                  '$address',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Image.asset('assets/images/welcome_in_home.png')),
          Gap(25.0.h),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Activities',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BusinessPlanMakerScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Image.asset(
                    'assets/images/business_plan_maker_in_home.png',
                  ),
                ),
              ),
              Gap(10.0.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryListBusinessPermitsAndLicensesScreen(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Image.asset(
                    'assets/images/permits_and_licenses_in_home.png',
                  ),
                ),
              ),
            ],
          ),
          Gap(25.0.h),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,),
            child: Text(
              'Tools',
              style: TextStyle(
                fontSize: 24 .sp,
                fontWeight: FontWeight.w900,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AskIBentureScreen(),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/ask_ibenture_in_home.png',
                  height: 150.h,
                  width: 150.w,
                ),
              ),
              Gap(10.0.w),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ModuleHomeScreen(),
                        ),
                      );
                },
                child: Image.asset(
                  'assets/images/educational_business_modules_in_home.png',
                  height: 150.h,
                  width: 150.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const CustomListTile({required this.title, required this.onTap, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering = false;
        });
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                color: _isHovering ? Colors.blue : Colors.black,
                decoration: _isHovering
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
            onTap: widget.onTap,
          ),
          const Divider(), // Line under each ListTile
        ],
      ),
    );
  }
}
