import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/components/fullscreen_image.dart';
import 'package:ibenture/components/pdf_viewer_educational_modules.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantsPermitsAndLicensesScreen extends StatefulWidget {
  const RestaurantsPermitsAndLicensesScreen({super.key});

  @override
  State<RestaurantsPermitsAndLicensesScreen> createState() =>
      _RestaurantsPermitsAndLicensesScreenState();
}

class _RestaurantsPermitsAndLicensesScreenState
    extends State<RestaurantsPermitsAndLicensesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isDialogShown = false;

  Map<String, bool> checklistItems = {
    'Barangay Clearance': false,
    'DTI Business Name Certificate': false,
    'Community Tax Certificate': false,
    'Sanitary Permit': false,
    'Contract of Lease': false,
    'Transfer Certificate of Title': false,
    'Tax Declaration': false,
  };

  @override
  void initState() {
    super.initState();
    _getChecklist();
  }

  void _getChecklist() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('restaurants').doc(userId).get();

        if (documentSnapshot.exists) {
          setState(() {
            for (String key in checklistItems.keys) {
              checklistItems[key] = documentSnapshot.get(key) ?? false;
            }
          });
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error getting data: $e');
      }
    }
  }

  void _updateChecklist() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;

      try {
        await _firestore
            .collection('restaurants')
            .doc(userId)
            .set(checklistItems);
      } catch (e) {
        // ignore: avoid_print
        print('Error updating data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isDialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showInitialAlert(context);
        isDialogShown = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Restaurants Permits and \nLicenses',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff311A72),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  style: GoogleFonts.kanit(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Apply for business permits and licenses to operate your restaurant legally.\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildNumberedChecklistItem(
                        checklistItems['Barangay Clearance'] ?? false,
                        'Barangay Clearance',
                        'Barangay Clearance from the local Barangay where your business is located. A photocopy of your SEC/DTI/CDC Registration and a contract of lease are required.',
                        'assets/images/barangay_clearance.png'),
                    _buildNumberedChecklistItem(
                        checklistItems['DTI Business Name Certificate'] ??
                            false,
                        'DTI Business Name Certificate',
                        'DTI Business Name Certificate for sole proprietors or SEC Registration for partnerships or corporations.',
                        'assets/images/dti_business_name_certificate.png'),
                    _buildNumberedChecklistItem(
                        checklistItems['Community Tax Certificate'] ?? false,
                        'Community Tax Certificate',
                        'Community Tax Certificate or CEDULA obtained at the City Treasurer\'s Office where your business is located.',
                        'assets/images/community_tax_certificate.png'),
                    _buildNumberedChecklistItem(
                        checklistItems['Sanitary Permit'] ?? false,
                        'Sanitary Permit',
                        'A Sanitary Permit is required to ensure that your restaurant complies with the health and sanitation standards set by the Department of Health.',
                        'assets/images/sanitary_permit.png'),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value:
                                        checklistItems['Contract of Lease'] ??
                                            false,
                                    onChanged: (value) {
                                      setState(() {
                                        checklistItems['Contract of Lease'] =
                                            value!;
                                        _updateChecklist();
                                      });
                                    },
                                    shape: const CircleBorder(),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Contract of Lease (if you are renting)',
                                      style: GoogleFonts.kanit(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(10.h),
                              Text(
                                'A Contract of Lease is required to prove that you have the right to use the property for your business.',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Gap(10.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PDFViewerScreen(
                                        pdfPath:
                                            'assets/modules/Contract-of-Lease.pdf',
                                        title: 'Contract-of-Lease.pdf',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff1A49F0).withOpacity(0.55),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            'assets/images/Invisible.png'),
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'See example document',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(10.h),
                              Row(
                                children: [
                                  Checkbox(
                                    value: checklistItems[
                                            'Transfer Certificate of Title'] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        checklistItems[
                                                'Transfer Certificate of Title'] =
                                            value!;
                                        _updateChecklist();
                                      });
                                    },
                                    shape: const CircleBorder(),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Transfer Certificate of Title (if you own the property)',
                                      style: GoogleFonts.kanit(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(10.h),
                              Text(
                                'A Transfer Certificate of Title is required to prove that you have the right to use the property for your business.',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Gap(10.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FullscreenImage(
                                        imagePath:
                                            'assets/images/transfer_certificate_of_title.png',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff1A49F0).withOpacity(0.55),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            'assets/images/Invisible.png'),
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'See example photo',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(10.h),
                              Row(
                                children: [
                                  Checkbox(
                                    value: checklistItems['Tax Declaration'] ??
                                        false,
                                    onChanged: (value) {
                                      setState(() {
                                        checklistItems['Tax Declaration'] =
                                            value!;
                                        _updateChecklist();
                                      });
                                    },
                                    shape: const CircleBorder(),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'Tax Declaration (if you own the property)',
                                      style: GoogleFonts.kanit(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Gap(10.h),
                              Text(
                                'A Tax Declaration is required to prove that you have the right to use the property for your business.',
                                style: GoogleFonts.kanit(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Gap(10.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FullscreenImage(
                                        imagePath:
                                            'assets/images/tax_declaration.png',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xff1A49F0).withOpacity(0.55),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            'assets/images/Invisible.png'),
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'See example photo',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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

  WidgetSpan _buildNumberedChecklistItem(
      bool isChecked, String title, String description, String imagePath) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: Card(
        margin: const EdgeInsets.only(bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        checklistItems[title] = value!;
                        _updateChecklist();
                      });
                    },
                    shape: const CircleBorder(),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(10.h),
              Text(
                description,
                style: GoogleFonts.kanit(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullscreenImage(
                        imagePath: imagePath,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xff1A49F0).withOpacity(0.55),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage('assets/images/Invisible.png'),
                        color: Colors.black,
                      ),
                      Text(
                        'See example photo',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showInitialAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'How to Set Up Your Restaurant Business Legally',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.kanit(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      children: [
                        const TextSpan(
                          text:
                              'Once you\'ve sorted out your legal business structure, it\'s time to secure the permits and licenses for a restaurant business in the Philippines.\n\nHere are the legalities a new food business owner should be familiar with:\n\n',
                        ),
                        const TextSpan(
                          text: 'Register with DTI or SEC\n\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text:
                              'The most pressing question for entrepreneurs looking to set up an online food business is: Do I need to register? The answer is yes! Even if you’re offering your services entirely online, you still need to apply for certain registrations and acquire permits.\n\nWhere you register your business, whether with SEC or DTI, would depend on whether your business is a Sole Proprietorship, Partnership, or Corporation.\n\nFor Sole Proprietors, you can register your business name with DTI ',
                        ),
                        TextSpan(
                          text: 'here',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(
                                  'https://bnrs.dti.gov.ph/ ?gclid=CjwKCAiA1aiMBhAUEiwACw25Mb0Ry6UPEP3k1bNxPR_oG-fBadE0h2Oa0vO-CjWwFVpJr115WljR9hoC9R8QAvD_BwE');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                        const TextSpan(
                          text:
                              '.\n\nCorporations and Partnerships can check out the requirements on the Securities and Exchange Commission ',
                        ),
                        TextSpan(
                          text: 'website.',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(
                                  'https://www.sec.gov.ph/notices-archive/sec-company-registration-system-crs-document-processing-is-temporarily-not-available-today-march-15-2019/#gsc.tab=0');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff311A72),
                  elevation: 5.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
