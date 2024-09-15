// front_page_stepper.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/provider/company_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class CompanyStepperScreen extends StatefulWidget {
  const CompanyStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CompanyStepperScreenState createState() => _CompanyStepperScreenState();
}

class _CompanyStepperScreenState extends State<CompanyStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(3, (_) => GlobalKey<FormState>());

  void _next(int length, CompanyProvider providerCompany) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }

    if (_currentStep == 1) {
      if (providerCompany.aiManagementTeamSuggestion.isEmpty) {
        providerCompany.fetchAIManagementTeamSuggestion(context);
      } else {
        providerCompany.clearAIManagementTeamSuggestion();
        providerCompany.fetchAIManagementTeamSuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerCompany.aiAdvisorsSuggestion.isEmpty) {
        providerCompany.fetchAIAdvisorsSuggestion(context);
      } else {
        providerCompany.clearAdvisorsSuggestion();
        providerCompany.fetchAIAdvisorsSuggestion(context);
      }
    }
  }

  void _previous(CompanyProvider providerCompany) {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });

    if (_currentStep == 0) {
      if (providerCompany.aiOverviewSuggestion.isEmpty) {
        providerCompany.fetchAIOverviewSuggestion(context);
      } else {
        providerCompany.clearAIOverviewSuggestion();
        providerCompany.fetchAIOverviewSuggestion(context);
      }
    } else if (_currentStep == 1) {
      if (providerCompany.aiManagementTeamSuggestion.isEmpty) {
        providerCompany.fetchAIManagementTeamSuggestion(context);
      } else {
        providerCompany.clearAIManagementTeamSuggestion();
        providerCompany.fetchAIManagementTeamSuggestion(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerCompany =
          Provider.of<CompanyProvider>(context, listen: false);
      providerCompany.initProviderBusinessPlan(context);
      providerCompany.fetchAIOverviewSuggestion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerCompany = Provider.of<CompanyProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Use this area to specify who owns your company. If there are multiple owners, describe each of them and how much of an ownership stake they have. Also, identify your company’s legal structure. Is it a sole proprietorship — that is, just you working for yourself? Or a partnership, such as a limited-liability corporation (LLC) or a partnership (LLP), where the profits pass through to the partners involved? Or a nonprofit organization? Or a proper S- or C-type corporation with its own tax obligations and the rest?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.overviewController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the overview for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerCompany.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.overviewController.text =
                        providerCompany.aiOverviewSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerCompany.aiOverviewSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[1],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Team',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Management Team',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: List the members of the management team, including yourself. Describe each person’s skills and experience and what they will be doing for the company. It’s OK if you don’t have everyone for a complete management team yet. In that case, make sure to identify gaps in your team that you intend to fill over time.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.managementTeamController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the management team for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerCompany.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.managementTeamController.text =
                        providerCompany.aiManagementTeamSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerCompany.aiManagementTeamSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[2],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Team',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Advisors',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe any mentors, investors, former professors, industry or subject-matter experts, knowledgeable friends or family members, small-business counselors, or others who can help you as a business owner.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.advisorsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the advisors for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerCompany.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.advisorsController.text =
                        providerCompany.aiAdvisorsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerCompany.aiAdvisorsSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company'),
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
                    onPressed: () => _previous(providerCompany),
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
                    onPressed: () => _next(stepContent.length, providerCompany),
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
                        provider.saveCompany();
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
