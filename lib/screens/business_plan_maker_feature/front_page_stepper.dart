import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/provider/front_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:validators/validators.dart' as validator;

class FrontPageStepperScreen extends StatefulWidget {
  const FrontPageStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FrontPageStepperScreenState createState() => _FrontPageStepperScreenState();
}

class _FrontPageStepperScreenState extends State<FrontPageStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(7, (_) => GlobalKey<FormState>());

  void _next(int length, FrontPageProvider providerFrontPage) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        providerFrontPage.fetchAITaglineSuggestions();
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }
  }

  void _previous(FrontPageProvider providerFrontPage) {
    setState(() {
      providerFrontPage.clearAICompanyNameSuggestions();
      providerFrontPage.fetchAICompanyNameSuggestions(context);
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    final providerFrontPage =
        Provider.of<FrontPageProvider>(context, listen: false);
    // providerFrontPage.isLoading = true;
    providerFrontPage.initProviderBusinessPlan(context);
    providerFrontPage.fetchAICompanyNameSuggestions(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerFrontPage = Provider.of<FrontPageProvider>(context);

    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(20.h),
              Text(
                'What is your company name?',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: const Color(0xFF311A72),
                ),
              ),
              Gap(20.h),
              TextFormField(
                controller: provider.companyNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please enter your company name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    providerFrontPage.initProviderBusinessPlan(context);
                    return provider.companyNameController.text.isEmpty
                        ? 'Please enter the company name'
                        : null;
                  }
                  return null;
                },
              ),
              Gap(40.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestions')),
              Gap(20.h),
              if (providerFrontPage.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GridView.builder(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2, // Adjust as needed
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                  ),
                  itemCount: providerFrontPage.aiCompanyNameSuggestions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.companyNameController.text =
                            providerFrontPage.aiCompanyNameSuggestions[index];
                      },
                      child: _buildSuggestionChip(
                          providerFrontPage.aiCompanyNameSuggestions[index]),
                    );
                  },
                ),
                Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[1],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your tagline?',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.taglineController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Please enter your tagline',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the tagline';
                }
                return null;
              },
            ),
            Gap(40.h),
            Container(
                alignment: Alignment.centerLeft, child: const Text('AI Suggestions')),
            Gap(20.h),
            if (providerFrontPage.isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Flexible(
                child: GridView.builder(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1, // Adjust as needed
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 10, // Space between columns
                    mainAxisSpacing: 10, // Space between rows
                  ),
                  itemCount: providerFrontPage.aiTaglineSuggestions.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.taglineController.text =
                            providerFrontPage.aiTaglineSuggestions[index];
                      },
                      child: _buildSuggestionChip(
                          providerFrontPage.aiTaglineSuggestions[index]),
                    );
                  },
                ),
              ),
              Gap(20.h),
          ],
        ),
      ),
      Form(
        key: _formKeys[2],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your full name?',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.fullnameController,
              decoration: const InputDecoration(
                  labelText: 'Please enter your full name',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Form(
        key: _formKeys[3],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your email address?',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.emailController,
              decoration: const InputDecoration(
                  labelText: 'Please enter your email address',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (EmailValidator.validate(value) == false) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Form(
        key: _formKeys[4],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your phone number?',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.phoneController,
              decoration: const InputDecoration(
                  labelText: 'Please enter your phone number',
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      Form(
        key: _formKeys[5],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your website? \n(Optional)',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.websiteController,
              decoration: const InputDecoration(
                  labelText: 'Please enter your website',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    !validator.isURL(value)) {
                  return 'Please enter a valid URL';
                }
                return null; // Valid if empty or if the input is a valid URL
              },
            ),
          ],
        ),
      ),
      Form(
        key: _formKeys[6],
        child: Column(
          children: [
            Gap(20.h),
            Text(
              'What is your address?',
              style: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF311A72),
              ),
            ),
            Gap(20.h),
            TextFormField(
              controller: provider.addressController,
              decoration: const InputDecoration(
                  labelText: 'Please enter your address',
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Front Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            providerFrontPage.clearAICompanyNameSuggestions();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            DottedLineStepper(
              currentStep: _currentStep,
              totalSteps: stepContent.length,
            ),
            Expanded(
              child: stepContent[_currentStep],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_currentStep > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF988cb9),
                    ),
                    onPressed: () => _previous(providerFrontPage),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (_currentStep < stepContent.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF311A72),
                    ),
                    onPressed: () =>
                        _next(stepContent.length, providerFrontPage),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (_currentStep == stepContent.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF311A72),
                    ),
                    onPressed: () {
                      if (_formKeys[_currentStep].currentState!.validate()) {
                        provider.saveFrontPage();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionChip(String suggestion) {
    if (suggestion.isNotEmpty) {
      return Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 10,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        margin: const EdgeInsets.all(2.5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Text(
            suggestion,
            textAlign: TextAlign.center,
          )),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class DottedLineStepper extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const DottedLineStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index <= currentStep ? const Color(0xFF311A72) : Colors.grey,
          ),
        );
      }),
    );
  }
}
