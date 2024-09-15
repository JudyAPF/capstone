import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/components/category_tile.dart';
import 'package:ibenture/data/categories_business_permits_and_licenses.dart';
// Import QuickAlert
import 'package:url_launcher/url_launcher.dart'; // Import QuickAlertType if needed

class CategoryListBusinessPermitsAndLicensesScreen extends StatelessWidget {
  CategoryListBusinessPermitsAndLicensesScreen({super.key});

  final categoryList = CATEGORIES;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInitialAlert(context);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Business Permits and \nLicenses',
          textAlign: TextAlign.center,
          style: GoogleFonts.kanit(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff311A72),
      ),
      body: GridView(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: categoryList.map((e) => CategoryTile(category: e)).toList(),
      ),
    );
  }

  void _showInitialAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Reminder',
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
                              'Before you apply for permits for a business in the Philippines, you need to decide what type of entity you want your business to be. Deciding your business structure will affect everything from how you pay your taxes, and what permits to apply for, to the extent of your liabilities as the owner.\n\nTo help you out, here are different business structures under Philippine law:\n\n1. Sole Proprietorship\n\nA Sole Proprietorship means the business is owned solely by one individual who is responsible for all assets and obligations. In this case, you get to enjoy all of the profits, but at the same time, shoulder all the possible losses as well. If you want full control and authority over the business, this is the business structure for you.\n\nSole Proprietorships must be registered with ',
                        ),
                        TextSpan(
                          text: 'Department of Trade and Industry',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(
                                  'https://bnrs.dti.gov.ph/registration');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                        const TextSpan(
                          text:
                              ' (DTI).\n\n2. Partnership\n\nIf you prefer to operate a business with other individuals with skills to complement your own, you should go down the Partnership route. Under the Civil Code of the Philippines, a Partnership\'s legal personality is separate from its owners.\n\nGo for a General Partnership if you and your partners are willing to share the unlimited liability of the business. But if you prefer an arrangement where only some partners get unlimited liability then a Limited Partnership is something you can look into.\n\nConsult with the ',
                        ),
                        TextSpan(
                          text: 'Securities and Exchange Commission',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(
                                  'https://www.sec.gov.ph/#gsc.tab=0');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                        ),
                        const TextSpan(
                          text:
                              ' (SEC) regarding the registration of your Partnership.',
                        ),
                        const TextSpan(
                          text:
                              '\n\n3. Corporation\n\nIf you plan to open a bigger restaurant, then you might want to consider starting a Corporation. With a minimum of five and a maximum of 15 shareholders, the Corporation limits your liabilities to equal the number of your shares in the business. Similar to a Partnership, a Corporation is treated as a separate entity from its owners, and must always be registered under the ',
                        ),
                        TextSpan(
                          text: 'SEC',
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
                        const TextSpan(
                          text:
                              '.\n\nIt is up to you to determine which legal structure best suits the business that you have in mind. Getting to the bottom of it takes a lot of planning, evaluating, and assessing, so if you\'re finding it difficult to make up your mind, consulting a business advisor would be of great help.',
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
