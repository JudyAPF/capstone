// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ibenture/screens/educational_modules/module1/IdeationScreen.dart';
import 'package:ibenture/screens/educational_modules/module2/BusinessPlanScreen.dart';
import 'package:ibenture/screens/educational_modules/module3/BrandingNamingScreen.dart';
import 'package:ibenture/screens/educational_modules/module4/SelectingLocationScreen.dart';
import 'package:ibenture/screens/educational_modules/module5/RegLicScreen.dart';

class ModuleHomeScreen extends StatelessWidget {
  const ModuleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Modules'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Image.asset(
                  'assets/images/moduleback.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _buildModuleCard(
                    context,
                    'Module 1: Idea Generation and Evaluation',
                    const IdeationScreen(),
                    Icons.lightbulb_outline,
                    Colors.orange,
                  ),
                  const SizedBox(height: 10), 
                  _buildModuleCard(
                    context,
                    'Module 2: Business Plan Development',
                    const BusinessPlanScreen(), 
                    Icons.business, 
                    Colors.blue, 
                  ),
                  const SizedBox(height: 10), 
                  _buildModuleCard(
                    context,
                    'Module 3: Branding and Naming',
                    const BrandingNamingScreen(), 
                    Icons.branding_watermark,
                    Colors.red, 
                  ),
                  const SizedBox(height: 10), 
                  _buildModuleCard(
                    context,
                    'Module 4: Selecting Location',
                    const SelectingLocationScreen(), 
                    Icons.location_on, 
                    Colors.green, 
                  ),
                  const SizedBox(height: 10), 
                  _buildModuleCard(
                    context,
                    'Module 5: Registration and Licensing',
                    const RegistrationLicensingScreen(), 
                    Icons.assignment, 
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, Widget? screen, IconData icon, Color iconColor) {
    return Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: () {
          if (screen != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$title is not available yet.')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(icon, color: iconColor, size: 30),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
