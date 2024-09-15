// front_page_stepper.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/components/fullscreen_image.dart';
import 'package:ibenture/provider/executive_summary_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class ExecutiveSummaryStepperScreen extends StatefulWidget {
  const ExecutiveSummaryStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExecutiveSummaryStepperScreenState createState() =>
      _ExecutiveSummaryStepperScreenState();
}

class _ExecutiveSummaryStepperScreenState
    extends State<ExecutiveSummaryStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(8, (_) => GlobalKey<FormState>());

  void _next(int length, ExecutiveSummaryProvider providerExecutiveSummary) {

    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }

    if (_currentStep == 1) {
      if (providerExecutiveSummary.aiSolutionSummarySuggestion.isEmpty) {
        providerExecutiveSummary.fetchAISolutionSummarySuggestion(context);
      } else {
        providerExecutiveSummary.clearAISolutionSummarySuggestion();
        providerExecutiveSummary.fetchAISolutionSummarySuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerExecutiveSummary.aiMarketSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIMarketSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIMarketSuggestion();
        providerExecutiveSummary.fetchAIMarketSuggestion(context);
      }
    } else if (_currentStep == 3)  {
      if (providerExecutiveSummary.aiCompetitionSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAICompetitionSuggestion(context);
      } else {
        providerExecutiveSummary.clearAICompetionSuggestion();
        providerExecutiveSummary.fetchAICompetitionSuggestion(context);
      }
    } else if (_currentStep == 4)  {
      if (providerExecutiveSummary.aiWhyUsSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIWhyUsSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIWhyUsSuggestion();
        providerExecutiveSummary.fetchAIWhyUsSuggestion(context);
      }
    } else if (_currentStep == 5)  {
      if (providerExecutiveSummary.aiForecastSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIForecastSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIForecastSuggestion();
        providerExecutiveSummary.fetchAIForecastSuggestion(context);
      }
    } else if (_currentStep == 7)  {
      if (providerExecutiveSummary.aiFinancingNeededSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIFinancingNeededSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIFinancingNeededSuggestion();
        providerExecutiveSummary.fetchAIFinancingNeededSuggestion(context);
      }
    }
  }

  void _previous(ExecutiveSummaryProvider providerExecutiveSummary) {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });

    if (_currentStep == 0) {
      if (providerExecutiveSummary.aiProblemSummarySuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIProblemSummarySuggestion(context);
      } else {
        providerExecutiveSummary.clearAIProblemSummarySuggestion();
        providerExecutiveSummary.fetchAIProblemSummarySuggestion(context);
      }
    } else if (_currentStep == 1) {
      if (providerExecutiveSummary.aiSolutionSummarySuggestion.isEmpty) {
        providerExecutiveSummary.fetchAISolutionSummarySuggestion(context);
      } else {
        providerExecutiveSummary.clearAISolutionSummarySuggestion();
        providerExecutiveSummary.fetchAISolutionSummarySuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerExecutiveSummary.aiMarketSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIMarketSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIMarketSuggestion();
        providerExecutiveSummary.fetchAIMarketSuggestion(context);
      }
    } else if (_currentStep == 3)  {
      if (providerExecutiveSummary.aiCompetitionSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAICompetitionSuggestion(context);
      } else {
        providerExecutiveSummary.clearAICompetionSuggestion();
        providerExecutiveSummary.fetchAICompetitionSuggestion(context);
      }
    } else if (_currentStep == 4)  {
      if (providerExecutiveSummary.aiWhyUsSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIWhyUsSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIWhyUsSuggestion();
        providerExecutiveSummary.fetchAIWhyUsSuggestion(context);
      }
    } else if (_currentStep == 5)  {
      if (providerExecutiveSummary.aiForecastSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIForecastSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIForecastSuggestion();
        providerExecutiveSummary.fetchAIForecastSuggestion(context);
      }
    } else if (_currentStep == 7)  {
      if (providerExecutiveSummary.aiFinancingNeededSuggestion.isEmpty) {
        providerExecutiveSummary.fetchAIFinancingNeededSuggestion(context);
      } else {
        providerExecutiveSummary.clearAIFinancingNeededSuggestion();
        providerExecutiveSummary.fetchAIFinancingNeededSuggestion(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerExecutiveSummary =
          Provider.of<ExecutiveSummaryProvider>(context, listen: false);
      providerExecutiveSummary.initProviderBusinessPlan(context);
      providerExecutiveSummary.fetchAIProblemSummarySuggestion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerExecutiveSummary =
        Provider.of<ExecutiveSummaryProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Opportunity',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Problem Summary',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe very briefly why your business needs to exist. What problem do you solve for your customers?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.problemSummaryController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the problem summary for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.problemSummaryController.text =
                        providerExecutiveSummary.aiProblemSummarySuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiProblemSummarySuggestion),
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
                'Opportunity',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Solution Summary',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Briefly summarize what your company does. The executive summary should be very short, and you can go into more detail later in the plan.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.solutionSummaryController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the solution summary for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.solutionSummaryController.text =
                        providerExecutiveSummary.aiSolutionSummarySuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiSolutionSummarySuggestion),
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
                'Opportunity',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Market',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your target customer or market segments. Again, keep things very brief in the executive summary and add more detail later in the plan.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.marketController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the market for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.marketController.text =
                        providerExecutiveSummary.aiMarketSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiMarketSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[3],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Opportunity',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Competition',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Summarize your key competition. Who will your customers also consider?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.competitionController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the competition for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.competitionController.text =
                        providerExecutiveSummary.aiCompetitionSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiCompetitionSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[4],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Opportunity',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Why Us?',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Write a brief overview of you and your team. Why are you the right people to build this business?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.whyUsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter why you are the right people to\n build this business';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.whyUsController.text =
                        providerExecutiveSummary.aiWhyUsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiWhyUsSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[5],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Expectations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Forecast',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Write a brief overview of your financial targets. How much do you plan to sell in the next year? What are your long-term sales goals? A tool like LivePlan can help you create an automated, accurate financial forecast to include in your business plan. You can also use other software to create your financials, such as Excel or Google Sheets.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.forecastController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the forecast for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.forecastController.text =
                        providerExecutiveSummary.aiForecastSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiForecastSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[6],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Expectations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Financial Highlights by Year (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Center(
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FullscreenImage(
                                    imagePath:
                                        'assets/images/financial_highlights_by_year.png')));
                      },
                      child: Image.asset(
                          'assets/images/financial_highlights_by_year.png'))),
              Gap(10.h),
              Text(
                'Instructions: Insert a chart of your key financial metrics here. You can use a tool like Excel or Google Sheets and paste it here.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.financialHighlightsByYear == null
                      ? 'Upload Image'
                      : provider.financialHighlightsByYear!.path
                          .split('/')
                          .last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_financialHighlightsByYear),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[7],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Expectations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Financing Needed (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: If you are writing a business plan to raise money for your business, include a brief summary of what you are looking for. If you aren’t raising money or getting a loan, you can skip this section.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.financingNeededController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecutiveSummary.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.financingNeededController.text =
                        providerExecutiveSummary.aiFinancingNeededSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecutiveSummary.aiFinancingNeededSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Executive Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            providerExecutiveSummary.clearAIProblemSummarySuggestion();
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
                    onPressed: () => _previous(providerExecutiveSummary),
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
                    onPressed: () => _next(
                        stepContent.length, providerExecutiveSummary),
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
                        provider.saveExecutiveSummary();
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

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1a49f0),
      ),
      label: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onClicked,
    );

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
