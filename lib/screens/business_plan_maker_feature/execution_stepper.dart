// front_page_stepper.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/provider/execution_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class ExecutionStepperScreen extends StatefulWidget {
  const ExecutionStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExecutionStepperScreenState createState() => _ExecutionStepperScreenState();
}

class _ExecutionStepperScreenState extends State<ExecutionStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(7, (_) => GlobalKey<FormState>());

  void _next(int length, ExecutionProvider providerExecution) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }

    if (_currentStep == 1) {
      if (providerExecution.aiSalesPlanSuggestion.isEmpty) {
        providerExecution.fetchAISalesPlanSuggestion(context);
      } else {
        providerExecution.clearAISalesPlanSuggestion();
        providerExecution.fetchAISalesPlanSuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerExecution.aiLocationsAndFacilitiesSuggestion.isEmpty) {
        providerExecution.fetchAILocationsAndFacilitiesSuggestion(context);
      } else {
        providerExecution.clearAILocationsAndFacilitiesSuggestion();
        providerExecution.fetchAILocationsAndFacilitiesSuggestion(context);
      }
    } else if (_currentStep == 3) {
      if (providerExecution.aiTechnologySuggestion.isEmpty) {
        providerExecution.fetchAITechnologySuggestion(context);
      } else {
        providerExecution.clearAITechnologySuggestion();
        providerExecution.fetchAITechnologySuggestion(context);
      }
    } else if (_currentStep == 4) {
      if (providerExecution.aiEquipmentAndToolsSuggestion.isEmpty) {
        providerExecution.fetchAIEquipmentAndToolsSuggestion(context);
      } else {
        providerExecution.clearAIEquipmentAndToolsSuggestion();
        providerExecution.fetchAIEquipmentAndToolsSuggestion(context);
      }
    } else if (_currentStep == 5) {
      if (providerExecution.aiMilestonesSuggestion.isEmpty) {
        providerExecution.fetchAIMilestonesSuggestion(context);
      } else {
        providerExecution.clearAIMilestonesSuggestion();
        providerExecution.fetchAIMilestonesSuggestion(context);
      }
    } else if (_currentStep == 6) {
      if (providerExecution.aiKeyMetricsSuggestion.isEmpty) {
        providerExecution.fetchAIKeyMetricsSuggestion(context);
      } else {
        providerExecution.clearAIKeyMetricsSuggestion();
        providerExecution.fetchAIKeyMetricsSuggestion(context);
      }
    }
  }

  void _previous(ExecutionProvider providerExecution) {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });

    if (_currentStep == 0) {
      if (providerExecution.aiMarketingPlanSuggestion.isEmpty) {
        providerExecution.fetchAIMarketingPlanSuggestion(context);
      } else {
        providerExecution.clearAIMarketingPlanSuggestion();
        providerExecution.fetchAIMarketingPlanSuggestion(context);
      }
    } else if (_currentStep == 1) {
      if (providerExecution.aiSalesPlanSuggestion.isEmpty) {
        providerExecution.fetchAISalesPlanSuggestion(context);
      } else {
        providerExecution.clearAISalesPlanSuggestion();
        providerExecution.fetchAISalesPlanSuggestion(context);
      }
    } else if (_currentStep == 2) {
      if (providerExecution.aiLocationsAndFacilitiesSuggestion.isEmpty) {
        providerExecution.fetchAILocationsAndFacilitiesSuggestion(context);
      } else {
        providerExecution.clearAILocationsAndFacilitiesSuggestion();
        providerExecution.fetchAILocationsAndFacilitiesSuggestion(context);
      }
    } else if (_currentStep == 3) {
      if (providerExecution.aiTechnologySuggestion.isEmpty) {
        providerExecution.fetchAITechnologySuggestion(context);
      } else {
        providerExecution.clearAITechnologySuggestion();
        providerExecution.fetchAITechnologySuggestion(context);
      }
    } else if (_currentStep == 4) {
      if (providerExecution.aiEquipmentAndToolsSuggestion.isEmpty) {
        providerExecution.fetchAIEquipmentAndToolsSuggestion(context);
      } else {
        providerExecution.clearAIEquipmentAndToolsSuggestion();
        providerExecution.fetchAIEquipmentAndToolsSuggestion(context);
      }
    } else if (_currentStep == 5) {
      if (providerExecution.aiMilestonesSuggestion.isEmpty) {
        providerExecution.fetchAIMilestonesSuggestion(context);
      } else {
        providerExecution.clearAIMilestonesSuggestion();
        providerExecution.fetchAIMilestonesSuggestion(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerExecution =
          Provider.of<ExecutionProvider>(context, listen: false);
      providerExecution.initProviderBusinessPlan(context);
      providerExecution.fetchAIMarketingPlanSuggestion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerExecution = Provider.of<ExecutionProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Marketing & Sales',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Marketing Plan',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Explain how you plan on getting the word out about your product to your target market(s). Will you use advertising? Perhaps you are developing a content marketing strategy. Whatever your marketing plans may be, describe them here.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.marketingPlanController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the marketing plan for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.marketingPlanController.text =
                        providerExecution.aiMarketingPlanSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecution.aiMarketingPlanSuggestion),
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
                'Marketing & Sales',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Sales Plan',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: If your company relies on salespeople to close sales deals, you need a sales plan. Your sales plan should explain how you convert people interested in your product or service into paying customers. If you are opening a food truck, this section is less important, and you can consider removing it. However, if you are starting a sales-heavy business enterprise software or a car dealership, then you need to document how you will nurture leads and close deals.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.salesPlanController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the sales plan for your business\n idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.salesPlanController.text =
                        providerExecution.aiSalesPlanSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecution.aiSalesPlanSuggestion),
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
                'Operations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Locations & Facilities',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your company’s physical locations. This might be your office, store locations, manufacturing plants, storage facilities — whatever is relevant to your business. How much space do you have available, and how well will it meet your current and future needs?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.locationsAndFacilitiesController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the locations and facilities for\n your business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.locationsAndFacilitiesController.text =
                        providerExecution.aiLocationsAndFacilitiesSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecution.aiLocationsAndFacilitiesSuggestion),
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
                'Operations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Technology',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe any important software, hardware, or other information technology that you use now or plan to use later to operate your business. That might include a point-of-sale system to take payments, an e-commerce engine for your website, a CRM solution for managing your pipeline, marketing tools for generating leads, and so on.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.technologyController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the technology for your business\n idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.technologyController.text =
                        providerExecution.aiTechnologySuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecution.aiTechnologySuggestion),
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
                'Operations',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Equipment & Tools',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: List any specialty equipment that you have or plan to acquire to do your work. This is an important component of the business plan for many industrial companies.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.equipmenAndToolsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the equipment and tools for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.equipmenAndToolsController.text =
                        providerExecution.aiEquipmentAndToolsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerExecution.aiEquipmentAndToolsSuggestion),
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
                'Milestones & Metrics',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Milestones',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: List your key milestones and the dates that you hope to accomplish them. If you’ve already accomplished key goals for your business, list them here as evidence that your business is getting traction – in other words, it’s getting positive attention from potential customers.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.melistonesController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the milestones for your business\n idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.melistonesController.text =
                        providerExecution.aiMilestonesSuggestion;
                  },
                  child: _buildSuggestionChip(
                    providerExecution.aiMilestonesSuggestion,
                  ),
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
                'Milestones & Metrics',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Key Metrics',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Explain which performance metrics are most important for understanding how your business is doing. What does success mean for you, and how will you know it when you see it?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.keyMetricsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the key metrics for your business\n idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerExecution.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.keyMetricsController.text =
                        providerExecution.aiKeyMetricsSuggestion;
                  },
                  child: _buildSuggestionChip(
                    providerExecution.aiKeyMetricsSuggestion,
                  ),
                ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Execution'),
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
                    onPressed: () => _previous(providerExecution),
                    child: const Text('Previous',
                        style: TextStyle(color: Colors.white)),
                  ),
                if (_currentStep < stepContent.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF311A72),
                    ),
                    onPressed: () =>
                        _next(stepContent.length, providerExecution),
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
                        provider.saveExecution();
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
