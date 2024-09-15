// front_page_stepper.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class AppendixStepperScreen extends StatefulWidget {
  const AppendixStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppendixStepperScreenState createState() =>
      _AppendixStepperScreenState();
}

class _AppendixStepperScreenState
    extends State<AppendixStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(4, (_) => GlobalKey<FormState>());

  void _next(int length) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }
  }

  void _previous() {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Center(
                child: Text(
                  'Projected Profit & Loss \n(With Monthly Detail) (Optional)',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF311A72),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(10.h),
              Text('⭐️ Pro tip: You can use tools online like QuickBooks or FreshBooks to help you create these financial statements. If you’re a small business owner, you can use a template to create these financial statements. You can also use a financial statement software to help you create there financial statements.', style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),),
              Gap(10.h),
              Image.asset(
                'assets/images/profit_and_loss_statement_with_monthly_detail.png',
              ),
              Gap(10.h),
              buildButton(
                  title: provider.profitAndLossStatementWithMonthlyDetail == null
                      ? 'Add Image'
                      : provider.profitAndLossStatementWithMonthlyDetail!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_profitAndLossStatementWithMonthlyDetail),
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
                'Profit and Loss Statement \n(Annual Detail) (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(10.h),
              Text('⭐️ Pro tip: Pro tip: You can use tools online like QuickBooks or FreshBooks to help you create these financial statements. If you’re a small business owner, you can use a template to create these financial statements. You can also use a financial statement software to help you create there financial statements.', style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),),
              Gap(10.h), 
              Image.asset(
                'assets/images/profit_and_loss_statement_annual_detail.png',
              ),
              Gap(10.h),
              buildButton(
                  title: provider.profitAndLossStatementAnnualDetail == null
                      ? 'Add Image'
                      : provider.profitAndLossStatementAnnualDetail!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_profitAndLossStatementAnnualDetail),
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
                'Balance Sheet (With Monthly Detail) \n(Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(10.h),
              Text('⭐️ Pro tip: You can use tools online like QuickBooks or FreshBooks to help you create these financial statements. If you’re a small business owner, you can use a template to create these financial statements. You can also use a financial statement software to help you create there financial statements.', style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),),
              Gap(10.h),
              Image.asset(
                'assets/images/balance_sheet_with_monthly_detail.png',
              ),
              Gap(10.h),
              buildButton(
                  title: provider.balanceSheetWithMonthlyDetail == null
                      ? 'Add Image'
                      : provider.balanceSheetWithMonthlyDetail!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_balanceSheetWithMonthlyDetail),
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
                'Balance Sheet (With Annual Detail) (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(10.h),
              Text('⭐️ Pro tip: You can use tools online like QuickBooks or FreshBooks to help you create these financial statements. If you’re a small business owner, you can use a template to create these financial statements. You can also use a financial statement software to help you create there financial statements.',style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),),
              Gap(10.h),
              Image.asset(
                'assets/images/balance_sheet_with_annual_detail.png',
              ),
              Gap(10.h),
              buildButton(
                  title: provider.balanceSheetWithAnnualDetail == null
                      ? 'Add Image'
                      : provider.balanceSheetWithAnnualDetail!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_balanceSheetWithAnnualDetail),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appendix'),
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
                    onPressed: _previous,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF988cb9),
                    ),
                    child: const Text('Previous', style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                if (_currentStep < stepContent.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF311A72),
                    ),
                    onPressed: () => _next(stepContent.length),
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
                        provider.saveAppendix();
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

  const DottedLineStepper({super.key, 
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
