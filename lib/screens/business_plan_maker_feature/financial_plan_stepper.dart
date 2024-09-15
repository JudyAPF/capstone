// front_page_stepper.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:ibenture/components/fullscreen_image.dart';
import 'package:ibenture/provider/financial_plan_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';

class FinancialPlanStepperScreen extends StatefulWidget {
  const FinancialPlanStepperScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FinancialPlanStepperScreenState createState() =>
      _FinancialPlanStepperScreenState();
}

class _FinancialPlanStepperScreenState
    extends State<FinancialPlanStepperScreen> {
  int _currentStep = 0;
  final _formKeys = List.generate(9, (_) => GlobalKey<FormState>());

  void _next(int length, FinancialPlanProvider providerFinancialPlan) {
    if (_formKeys[_currentStep].currentState!.validate()) {
      setState(() {
        _currentStep < length - 1
            ? _currentStep += 1
            : _currentStep = length - 1;
      });
    }
    if (_currentStep == 4) {
      if (providerFinancialPlan.aiUseOfFundsSuggestion.isEmpty) {
        providerFinancialPlan.fetchAIUseOfFundsSuggestion(context);
      } else {
        providerFinancialPlan.clearAIUseOfFundsSuggestion();
        providerFinancialPlan.fetchAIUseOfFundsSuggestion(context);
      }
    } else if (_currentStep == 5) {
      if (providerFinancialPlan.aiSourcesOfFundsSuggestion.isEmpty) {
        providerFinancialPlan.fetchAISourcesOfFundsSuggestion(context);
      } else {
        providerFinancialPlan.clearAISourcesOfFundsSuggestion();
        providerFinancialPlan.fetchAISourcesOfFundsSuggestion(context);
      }
    }
  }

  void _previous(FinancialPlanProvider providerFinancialPlan) {
    setState(() {
      _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
    });

    if (_currentStep == 0) {
      if (providerFinancialPlan.aiKeyAssumptionsSuggestion.isEmpty) {
        providerFinancialPlan.fetchAIKeyAssumptionsSuggestion(context);
      } else {
        providerFinancialPlan.clearAIKeyAssumptionsSuggestion();
        providerFinancialPlan.fetchAIKeyAssumptionsSuggestion(context);
      }
    } else if (_currentStep == 4) {
      if (providerFinancialPlan.aiUseOfFundsSuggestion.isEmpty) {
        providerFinancialPlan.fetchAIUseOfFundsSuggestion(context);
      } else {
        providerFinancialPlan.clearAIUseOfFundsSuggestion();
        providerFinancialPlan.fetchAIUseOfFundsSuggestion(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final providerFinancialPlan =
          Provider.of<FinancialPlanProvider>(context, listen: false);
      providerFinancialPlan.initProviderBusinessPlan(context);
      providerFinancialPlan.fetchAIKeyAssumptionsSuggestion(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessPlanMakerProvider>(context);
    final providerFinancialPlan = Provider.of<FinancialPlanProvider>(context);
    final stepContent = [
      Form(
        key: _formKeys[0],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Forecast',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Key Assumptions',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe how you came up with the values in your financial forecast. Did you project your revenue based on past results, market research, your best guess at how many people visit your store and what percentage of them might buy, or some other method? What kind of growth are you assuming? What are your key hires and notable expenses? What profit level do you expect to generate?',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.keyAssumptionsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the key assumptions for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerFinancialPlan.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.keyAssumptionsController.text =
                        providerFinancialPlan.aiKeyAssumptionsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerFinancialPlan.aiKeyAssumptionsSuggestion),
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
                'Forecast',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Revenue by Month (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions:\nCreate a chart to show your projected monthly revenue for the first year.\nSteps:\nEstimate Monthly Revenue:\nList expected revenue for each month.\nCreate the Chart:\nUse Excel or Google Sheets.\nEnter your data and create a bar or line chart.\nLabel the chart and each month.\nInclude in Plan:\nSave and upload the chart.\nAdd a brief note about key trends.\nTips:\nUse Clear Visuals.\nAlign with Your Financial Plan.\nHighlight Important Trends.\nThis will help illustrate your expected revenue trends clearly.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath: 'assets/images/revenue_by_month.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/revenue_by_month.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.revenueByMonth == null
                      ? 'Add Image'
                      : provider.revenueByMonth!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_revenueByMonth),
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
                'Forecast',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Expenses by Month (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Create a chart to display your projected monthly expenses for the first year. This will help visualize and track your spending trends.\n1. Estimate Monthly Costs: List fixed (e.g., rent, salaries) and variable (e.g., materials, utilities) expenses for each month.\n2. Create a Chart:\n• Use Excel, Google Sheets, or similar.\n• Input estimates and generate a clear bar or line chart.\n• Label it "Projected Monthly Expenses."\n3. Include in Your Plan:\n• Save chart as an image.\n• Explain any significant expense patterns.\nTips:\n• Be precise and clear.\n• Align with your financial plan.\n• Highlight major cost changes.\nThese steps will help track and visualize your spending trends effectively.\n',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath: 'assets/images/months_in_year_1.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/months_in_year_1.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.expensesByMonth == null
                      ? 'Add Image'
                      : provider.expensesByMonth!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_expensesByMonth),
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
                'Forecast',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Net Profit (or Loss) by Year (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Calculate Revenue and Expenses:\n• Determine total income and all expenses.\nCompute Net Profit (or Loss):\n• Subtract total expenses from income.\nCreate a Profit Statement:\n• Use Excel or Google Sheets.\n•Input data and calculate net profit\nVisualize with a Chart:\n• Create a clear annual net profit (or loss) chart.\nInclude in Your Report:\n• Save chart as an image.\n• Add brief analysis of financial trends.\nTips:\n• Ensure accuracy.\n• Label figures clearly.\n• Analyze profit (or loss) factors.\nThese steps will effectively summarize your annual financial performance for strategic insights.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath:
                            'assets/images/net_profit_or_loss_by_year.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/net_profit_or_loss_by_year.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.netProfitOrLossByYear == null
                      ? 'Add Image'
                      : provider.netProfitOrLossByYear!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_netProfitOrLossByYear),
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
                'Financing',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Use of Funds (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: If your forecast includes loans, investments, or other financing, use this space to explain what you plan to do with that money.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.useOfFundsController,
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
              if (providerFinancialPlan.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.useOfFundsController.text =
                        providerFinancialPlan.aiUseOfFundsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerFinancialPlan.aiUseOfFundsSuggestion),
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
                'Financing',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Sources of Funds',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Instructions: Describe your financing plans. Are you investing your own money in the business? Do you have a credit card or line of credit? What other types of funds — personal or business loans, equity investments from others, etc. — do you expect to receive and when? Understandably, you do not yet have the full details of future financing. Just explain what you do know and when you wish to sort out the details.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              TextFormField(
                controller: provider.sourcesOfFundsController,
                minLines: 5, // Sets the minimum number of lines to display
                maxLines: null, // Allows the text field to expand as needed
                decoration: const InputDecoration(
                  border: OutlineInputBorder(), // Outlined border
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the sources of funds for your\n business idea';
                  }
                  return null;
                },
              ),
              Gap(20.h),
              Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('AI Suggestion')),
              Gap(20.h),
              if (providerFinancialPlan.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                GestureDetector(
                  onTap: () {
                    provider.sourcesOfFundsController.text =
                        providerFinancialPlan.aiSourcesOfFundsSuggestion;
                  },
                  child: _buildSuggestionChip(
                      providerFinancialPlan.aiSourcesOfFundsSuggestion),
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
                'Statements',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Projected Profit & Loss (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Estimate Revenue:\nProject income from sales, services, etc.\nCalculate Expenses:\nList and estimate all costs, including fixed and variable expenses.\nCompute Profit:\nSubtract total expenses from revenue to find gross profit.\nDeduct taxes and other costs for net profit.\nCreate a Profit and Loss Statement:\nUse Excel or Google Sheets for detailed calculations.\nExample:\nProjected Profit and Loss for Year 2024\n- Revenue: ₱600,000\n- Sales: ₱500,000\n- Services: ₱100,000\n- Expenses: ₱430,000\nCost of Goods Sold, Salaries, Rent, Marketing Gross Profit**: ₱170,000\nNet Profit (Before Taxes): Adjust for taxes and other costs.\nThese steps and example simplify projecting profit and loss for effective financial planning or reporting.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath:
                            'assets/images/projected_profit_and_loss.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/projected_profit_and_loss.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.projectedProfitAndLoss == null
                      ? 'Add Image'
                      : provider.projectedProfitAndLoss!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_projectedProfitAndLoss),
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
                'Statements',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Projected Balance Sheet (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'List Assets:\n• Identify all owned assets (e.g., cash, inventory, equipment).\nCalculate Liabilities:\n• Determine debts and obligations (e.g., loans, accounts payable).\nCompute Equity:\n• Calculate assets minus liabilities for equity (e.g., owner\'s equity).\nOrganize and Create:\n• Classify into current and non-current categories.\n• Use Excel or accounting software for accuracy.\nExample:\nBalance Sheet as of [Date]\nAssets:\n Current:\n  - Cash: ₱50,000\n  - Inventory: ₱30,000\n Non-current:\n  - Equipment: ₱100,000\n  - Property: ₱200,000\n  - Total Assets: ₱380,000\nLiabilities:\n Current:\n  - Accounts Payable: ₱20,000\n  - Short-term Loans: ₱10,000\n Non-current:\n  - Long-term Loans: ₱50,000\n  - Total Liabilities: ₱80,000\nEquity:\n - Owner\'s Equity: ₱300,000\n - Total Liabilities and Equity: ₱380,000',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath: 'assets/images/projected_balance_sheet.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/projected_balance_sheet.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.projectedBalanceSheet == null
                      ? 'Add Image'
                      : provider.projectedBalanceSheet!.path.split('/').last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_projectedBalanceSheet),
            ],
          ),
        ),
      ),
      Form(
        key: _formKeys[8],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(10.h),
              Text(
                'Statements',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Projected Cash Flow Statement (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF311A72),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10.h),
              Text(
                'Estimate Cash Inflows:\n- Project all sources of cash inflow, such as sales revenue, investments, and loans.\nForecast Cash Outflow\n- List expected cash outflows, including operating expenses, loan repayments, taxes, and dividends.\nCalculate Net Cash Flow:\n- Compute the net cash flow by subtracting total cash outflows from total cash inflows for each period.\nPrepare Cash Flow Statement:\n• Use Excel, Google Sheets, or accounting software to organize and calculate figures accurately.\nReview and Analyze:\n• Ensure the statement reflects expected financial activities.\n• Analyze trends and potential cash flow issues.\n Example:\nProjected Cash Flow Statement for Year 2024\nCash Inflows:\n  - Sales Revenue: ₱600,000\n  - Investment: ₱50,000\n  - Total Cash Inflows: ₱650,000\nCash Outflows:\n  - Operating Expenses: ₱400,000\n  - Loan Repayments: ₱50,000\n  - Taxes: ₱20,000\n  - Dividends: ₱10,000\n  - Total Cash Outflows: ₱480,000\nNet Cash Flow: ₱650,000 - ₱480,000 = ₱170,000\nThis concise guide and example help in projecting and preparing a cash flow statement to manage and analyze your business\'s liquidity effectively.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FullscreenImage(
                        imagePath:
                            'assets/images/projected_cash_flow_statement.png',
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  'assets/images/projected_cash_flow_statement.png',
                ),
              ),
              Gap(10.h),
              buildButton(
                  title: provider.projectedCashFlowStatement == null
                      ? 'Add Image'
                      : provider.projectedCashFlowStatement!.path
                          .split('/')
                          .last,
                  icon: Icons.image_outlined,
                  onClicked: provider.pick_projectedCashFlowStatement),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Plan'),
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
                    onPressed: () => _previous(providerFinancialPlan),
                    child: const Text('Previous',
                        style: TextStyle(color: Colors.white)),
                  ),
                if (_currentStep < stepContent.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF311A72),
                    ),
                    onPressed: () =>
                        _next(stepContent.length, providerFinancialPlan),
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
                        provider.saveFinancialPlan();
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
