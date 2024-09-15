// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/provider/opportunity_provider%20.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class OpportunityStepperScreen extends StatefulWidget {
  const OpportunityStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OpportunityStepperScreenState createState() =>
      _OpportunityStepperScreenState();
}

class _OpportunityStepperScreenState extends State<OpportunityStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(5, (_) => GlobalKey<FormState>());

  void _next(int length, OpportunityProvider providerOpportunity) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }

    if (_currentStep == 1) {
      if (providerOpportunity.aiOurSolutionSuggestion.isEmpty) {
        providerOpportunity.fetchAIOurSolutionSuggestion(context);
      } else {
        providerOpportunity.clearAIOurSolutionSuggestion();
        providerOpportunity.fetchAIOurSolutionSuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerOpportunity.aiMarketSizeAndSegmentsSuggestion.isEmpty) {
        providerOpportunity.fetchAIMarketSizeAndSegmentsSuggestion(context);
      } else {
        providerOpportunity.clearAIMarketSizeAndSegmentsSuggestion();
        providerOpportunity.fetchAIMarketSizeAndSegmentsSuggestion(context);
      }
    } else if (_currentStep == 3) {
      if (providerOpportunity.aiCurrentAlternativesSuggestion.isEmpty) {
        providerOpportunity.fetchAICurrentAlternativesSuggestion(context);
      } else {
        providerOpportunity.clearAICurrentAlternativesSuggestion();
        providerOpportunity.fetchAICurrentAlternativesSuggestion(context);
      }
    } else if (_currentStep == 4) {
      if (providerOpportunity.aiOurAdvantagesSuggestion.isEmpty) {
        providerOpportunity.fetchAIOurAdvantagesSuggestion(context);
      } else {
        providerOpportunity.clearAIOurAdvantagesSuggestion();
        providerOpportunity.fetchAIOurAdvantagesSuggestion(context);
      }
    }
  }

  void _previous(OpportunityProvider providerOpportunity) {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });
    if (_currentStep == 0) {
      if (providerOpportunity.aiProblemWorthSolvingSuggestion.isEmpty) {
        providerOpportunity.fetchAIProblemWorthSolvingSuggestion(context);
      } else {
        providerOpportunity.clearAIProblemWorthSolvingSuggestion();
        providerOpportunity.fetchAIProblemWorthSolvingSuggestion(context);
      }
    } else if (_currentStep == 1) {
      if (providerOpportunity.aiOurSolutionSuggestion.isEmpty) {
        providerOpportunity.fetchAIOurSolutionSuggestion(context);
      } else {
        providerOpportunity.clearAIOurSolutionSuggestion();
        providerOpportunity.fetchAIOurSolutionSuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerOpportunity.aiMarketSizeAndSegmentsSuggestion.isEmpty) {
        providerOpportunity.fetchAIMarketSizeAndSegmentsSuggestion(context);
      } else {
        providerOpportunity.clearAIMarketSizeAndSegmentsSuggestion();
        providerOpportunity.fetchAIMarketSizeAndSegmentsSuggestion(context);
      }
    } else if (_currentStep == 3) {
      if (providerOpportunity.aiCurrentAlternativesSuggestion.isEmpty) {
        providerOpportunity.fetchAICurrentAlternativesSuggestion(context);
      } else {
        providerOpportunity.clearAICurrentAlternativesSuggestion();
        providerOpportunity.fetchAICurrentAlternativesSuggestion(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerOpportunity =
          Provider.of<OpportunityProvider>(context, listen: false);
      providerOpportunity.initProviderBusinessPlan(context);
      providerOpportunity.fetchAIProblemWorthSolvingSuggestion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerOpportunity = Provider.of<OpportunityProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Problem & Solution',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Problem Worth Solving',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Write more details about the problem you are solving than you provided in the executive summary. What do your customers need? Do they need a better product, a cheaper product, or just a store in a better location? Describe why customers will want to buy from you.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.problemWorthSolvingController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the problem worth solving for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerOpportunity.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.problemWorthSolvingController.text =
                        providerOpportunity.aiProblemWorthSolvingSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerOpportunity.aiProblemWorthSolvingSuggestion),
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
                'Problem & Solution',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Our Solution',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Provide additional detail, beyond what you wrote in the Executive Summary, about your product or service. What is unique and special about your company that’s going to set it apart from the competition?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.solutionController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the solution for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerOpportunity.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.solutionController.text =
                        providerOpportunity.aiOurSolutionSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerOpportunity.aiOurSolutionSuggestion),
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
                'Target Market',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                '⭐️ Pro tip: The more specific you can be about your target market, the better.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF311A72),
                ),
              ),
              Gap(10.h),
              Text(
                'Market Size & Segments',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your key customers – who they are and what their key attributes are. If your company is targeting multiple customer groups (also called ‘segments’), describe each group here. If you can, include details about how many people are in each segment and how large the total market is.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.marketSizeAndSegmentsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the market size and segments of\n your target market for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerOpportunity.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.marketSizeAndSegmentsController.text =
                        providerOpportunity.aiMarketSizeAndSegmentsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerOpportunity.aiMarketSizeAndSegmentsSuggestion),
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
                'Competition',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Current Alternatives',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your current alternatives. Who are your competitors? What are the alternatives to your product or service? What are customers currently doing to solve the problem you are solving?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.currentAlternativesController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the current alternatives to your\n product or service for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerOpportunity.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.currentAlternativesController.text =
                        providerOpportunity.aiCurrentAlternativesSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerOpportunity.aiCurrentAlternativesSuggestion),
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
                'Competition',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Our Advantages',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your competitive advantages. What makes your company special? Why will customers choose you over your competitors? What are the key things that you will do to make your product or service stand out?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.advantagesController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the advantages of your product or\n service for your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerOpportunity.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.advantagesController.text =
                        providerOpportunity.aiOurAdvantagesSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerOpportunity.aiOurAdvantagesSuggestion),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity'),
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
                    onPressed: () => _previous(providerOpportunity),
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
                        _next(stepContent.length, providerOpportunity),
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
                        provider.saveOpportunity();
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
