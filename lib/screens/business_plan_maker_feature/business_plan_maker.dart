// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/components/category_tile2.dart';
import 'package:ibenture/data/categories_business_permits_and_licenses.dart';
import 'package:ibenture/screens/business_plan_maker_feature/appendix_stepper.dart';
import 'package:ibenture/screens/business_plan_maker_feature/company_stepper.dart';
import 'package:ibenture/screens/business_plan_maker_feature/execution_stepper.dart';
import 'package:ibenture/screens/business_plan_maker_feature/executive_summary_stepper.dart';
import 'package:ibenture/screens/business_plan_maker_feature/financial_plan_stepper.dart';
import 'package:ibenture/screens/business_plan_maker_feature/opportunity_stepper%20.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/screens/business_plan_maker_feature/front_page_stepper.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class BusinessPlanMakerScreen extends StatefulWidget {
  const BusinessPlanMakerScreen({super.key});

  @override
  State<BusinessPlanMakerScreen> createState() =>
      _BusinessPlanMakerScreenState();
}

class _BusinessPlanMakerScreenState extends State<BusinessPlanMakerScreen>
    with WidgetsBindingObserver {
  int _currentStep = 0;
  final categoryList = CATEGORIES;
  bool isBusinessTypeShown = false;

  @override
  void initState() {
    super.initState();
  }

  void showBusinessType(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
            return true;
          },
          child: AlertDialog(
            title: Text(
              'Choose a Business Type',
              textAlign: TextAlign.center,
              style: GoogleFonts.kanit(
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: categoryList
                      .map((e) => CategoryTile2(category: e))
                      .toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isBusinessTypeShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showBusinessType(context);
        isBusinessTypeShown = true;
      });
    }

    final provider = Provider.of<BusinessPlanMakerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF311A72),
        centerTitle: true,
        title: const Text(
          'Business Plan Maker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Consumer<BusinessPlanMakerProvider>(
                        builder: (context, provider, child) {
                          return Stepper(
                            currentStep: _currentStep,
                            onStepTapped: (int index) {
                              setState(() {
                                _currentStep = index;
                              });
                            },
                            controlsBuilder: (BuildContext context,
                                ControlsDetails details) {
                              return const SizedBox
                                  .shrink(); // Remove default buttons
                            },
                            steps: [
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Front Page'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      setState(() {
                                        _currentStep = 0;
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FrontPageStepperScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isFrontPageComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: _currentStep == 0,
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Executive Summary'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isFrontPageComplete) {
                                        setState(() {
                                          _currentStep = 1;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ExecutiveSummaryStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Front Page before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isExecutiveSummaryComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isFrontPageComplete &&
                                    _currentStep == 1,  
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Opportunity'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isExecutiveSummaryComplete) {
                                        setState(() {
                                          _currentStep = 2;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OpportunityStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Executive Summary before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isOpportunityComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isExecutiveSummaryComplete &&
                                    _currentStep == 2,
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Execution'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isOpportunityComplete) {
                                        setState(() {
                                          _currentStep = 3;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ExecutionStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Opportunity before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isExecutionComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isOpportunityComplete &&
                                    _currentStep == 3,
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Company'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isExecutionComplete) {
                                        setState(() {
                                          _currentStep = 4;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CompanyStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Execution before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isCompanyComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isExecutionComplete &&
                                    _currentStep == 4,
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Financial Plan'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isCompanyComplete) {
                                        setState(() {
                                          _currentStep = 5;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FinancialPlanStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Company before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isFinancialPlanComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isCompanyComplete &&
                                    _currentStep == 5,
                              ),
                              Step(
                                title: Card(
                                  child: ListTile(
                                    title: const Text('Appendix'),
                                    trailing: const Icon(Icons.arrow_forward),
                                    onTap: () {
                                      if (provider.isFinancialPlanComplete) {
                                        setState(() {
                                          _currentStep = 6;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const AppendixStepperScreen(),
                                          ),
                                        );
                                      } else {
                                        QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            title: 'Error',
                                            text:
                                                'Please complete the Financial Plan before proceeding');
                                      }
                                    },
                                  ),
                                ),
                                content: const SizedBox.shrink(),
                                state: provider.isAppendixComplete
                                    ? StepState.complete
                                    : StepState.indexed,
                                isActive: provider.isFinancialPlanComplete &&
                                    _currentStep == 6,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF311A72),
              ),
              onPressed: () {
                if (provider.isFrontPageComplete) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: const Text('Choose Format'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Word'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.of(context).pop();
                              provider.generatePdf(provider: provider);
                            },
                            child: const Text('PDF'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Error',
                      text: 'Please complete all steps before generate');
                }
              },
              child: Text('Generate',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> loadFontData(String fontPath) async {
    final data = await rootBundle.load(fontPath);
    return data.buffer.asUint8List();
  }
}
