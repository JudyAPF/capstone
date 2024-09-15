import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class BusinessPlanMakerProvider extends ChangeNotifier {
  String selectedCategory = '';

  void setSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  String get getSelectedCategory => selectedCategory;

  String selectedSubCategory = '';

  void setSelectedSubCategory(String subCategory) {
    selectedSubCategory = subCategory;
    notifyListeners();
  }

  String get getSelectedSubCategory => selectedSubCategory;

  var isBusinessPlanOpened = false;

  void businessPlanOpened() {
    isBusinessPlanOpened = true;
    notifyListeners();
  }

  void businessPlanClosed() {
    isBusinessPlanOpened = false;
    notifyListeners();
  }

  //Front Page
  final _companyNameController = TextEditingController();
  final _taglineController = TextEditingController();
  final _dateController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _websiteController = TextEditingController();
  final _addressController = TextEditingController();

  //Opportunity
  final _problemWorthSolvingController = TextEditingController();
  final _solutionController = TextEditingController();
  final _marketSizeAndSegmentsController = TextEditingController();
  final _currentAlternativesController = TextEditingController();
  final _advantagesController = TextEditingController();

  //Execution
  final _marketingPlanController = TextEditingController();
  final _salesPlanController = TextEditingController();
  final _locationsAndFacilitiesController = TextEditingController();
  final _technologyController = TextEditingController();
  final _equipmenAndToolsController = TextEditingController();
  final _melistonesController = TextEditingController();
  final _keyMetricsController = TextEditingController();

  //Company
  final _overviewController = TextEditingController();
  final _managementTeamController = TextEditingController();
  final _advisorsController = TextEditingController();

  //Financial Plan
  final _keyAssumptionsController = TextEditingController();
  File? _revenueByMonth;
  File? _expensesByMonth;
  File? _netProfitOrLossByYear;
  final _useOfFundsController = TextEditingController();
  final _sourcesOfFundsController = TextEditingController();
  File? _projectedProfitAndLoss;
  File? _projectedBalanceSheet;
  File? _projectedCashFlowStatement;

  //Appendix
  File? _profitAndLossStatementWithMonthlyDetail;
  File? _profitAndLossStatementAnnualDetail;
  File? _balanceSheetWithMonthlyDetail;
  File? _balanceSheetWithAnnualDetail;

  //Executive Summary
  final _problemSummaryController = TextEditingController();
  final _solutionSummaryController = TextEditingController();
  final _marketController = TextEditingController();
  final _competitionController = TextEditingController();
  final _whyUsController = TextEditingController();
  final _forecastController = TextEditingController();
  File? _financialHighlightsByYear;
  final _financingNeededController = TextEditingController();

  bool _isFrontPageComplete = false;
  bool _isOpportunityComplete = false;
  bool _isExecutionComplete = false;
  bool _isCompanyComplete = false;
  bool _isFinancialPlanComplete = false;
  bool _isAppendixComplete = false;
  bool _isExecutiveSummaryComplete = false;

  bool get isFrontPageComplete => _isFrontPageComplete;
  bool get isOpportunityComplete => _isOpportunityComplete;
  bool get isExecutionComplete => _isExecutionComplete;
  bool get isCompanyComplete => _isCompanyComplete;
  bool get isFinancialPlanComplete => _isFinancialPlanComplete;
  bool get isAppendixComplete => _isAppendixComplete;
  bool get isExecutiveSummaryComplete => _isExecutiveSummaryComplete;

  // ignore: non_constant_identifier_names
  Future pick_revenueByMonth() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _revenueByMonth =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_revenueByMonth == null) return;

      final revenueByMonthTemporary = File(_revenueByMonth.path);
      this._revenueByMonth = revenueByMonthTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _revenueByMonth: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_expensesByMonth() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _expensesByMonth =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_expensesByMonth == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _expensesByMonthTemporary = File(_expensesByMonth.path);
      this._expensesByMonth = _expensesByMonthTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _expensesByMonth: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_netProfitOrLossByYear() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _netProfitOrLossByYear =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_netProfitOrLossByYear == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _netProfitOrLossByYearTemporary = File(_netProfitOrLossByYear.path);
      this._netProfitOrLossByYear = _netProfitOrLossByYearTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _netProfitOrLossByYear: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_projectedProfitAndLoss() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedProfitAndLoss =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_projectedProfitAndLoss == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedProfitAndLossTemporary =
          File(_projectedProfitAndLoss.path);
      this._projectedProfitAndLoss = _projectedProfitAndLossTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _projectedProfitAndLoss: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_projectedBalanceSheet() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedBalanceSheet =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_projectedBalanceSheet == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedBalanceSheetTemporary = File(_projectedBalanceSheet.path);
      this._projectedBalanceSheet = _projectedBalanceSheetTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _projectedBalanceSheet: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_projectedCashFlowStatement() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedCashFlowStatement =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_projectedCashFlowStatement == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _projectedCashFlowStatementTemporary =
          File(_projectedCashFlowStatement.path);
      this._projectedCashFlowStatement = _projectedCashFlowStatementTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _projectedCashFlowStatement: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_profitAndLossStatementWithMonthlyDetail() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _profitAndLossStatementWithMonthlyDetail =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_profitAndLossStatementWithMonthlyDetail == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _profitAndLossStatementWithMonthlyDetailTemporary =
          File(_profitAndLossStatementWithMonthlyDetail.path);
      this._profitAndLossStatementWithMonthlyDetail =
          _profitAndLossStatementWithMonthlyDetailTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _profitAndLossStatementWithMonthlyDetail: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_profitAndLossStatementAnnualDetail() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _profitAndLossStatementAnnualDetail =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_profitAndLossStatementAnnualDetail == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _profitAndLossStatementAnnualDetailTemporary =
          File(_profitAndLossStatementAnnualDetail.path);
      this._profitAndLossStatementAnnualDetail =
          _profitAndLossStatementAnnualDetailTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _profitAndLossStatementAnnualDetail: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_balanceSheetWithMonthlyDetail() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _balanceSheetWithMonthlyDetail =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_balanceSheetWithMonthlyDetail == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _balanceSheetWithMonthlyDetailTemporary =
          File(_balanceSheetWithMonthlyDetail.path);
      this._balanceSheetWithMonthlyDetail =
          _balanceSheetWithMonthlyDetailTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _balanceSheetWithMonthlyDetail: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_balanceSheetWithAnnualDetail() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _balanceSheetWithAnnualDetail =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_balanceSheetWithAnnualDetail == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _balanceSheetWithAnnualDetailTemporary =
          File(_balanceSheetWithAnnualDetail.path);
      this._balanceSheetWithAnnualDetail =
          _balanceSheetWithAnnualDetailTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _balanceSheetWithAnnualDetail: $e');
    }
    notifyListeners();
  }

  // ignore: non_constant_identifier_names
  Future pick_financialHighlightsByYear() async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final _financialHighlightsByYear =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (_financialHighlightsByYear == null) return;

      // ignore: no_leading_underscores_for_local_identifiers
      final _financialHighlightsByYearTemporary =
          File(_financialHighlightsByYear.path);
      this._financialHighlightsByYear = _financialHighlightsByYearTemporary;
      notifyListeners();
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick _financialHighlightsByYear: $e');
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _taglineController.dispose();
    _dateController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _websiteController.dispose();
    _addressController.dispose();
    _financingNeededController.dispose();

    _problemWorthSolvingController.dispose();
    _solutionController.dispose();
    _marketSizeAndSegmentsController.dispose();
    _currentAlternativesController.dispose();
    _advantagesController.dispose();

    _marketingPlanController.dispose();
    _salesPlanController.dispose();
    _locationsAndFacilitiesController.dispose();
    _technologyController.dispose();
    _equipmenAndToolsController.dispose();
    _melistonesController.dispose();
    _keyMetricsController.dispose();

    _overviewController.dispose();
    _managementTeamController.dispose();
    _advisorsController.dispose();

    _keyAssumptionsController.dispose();
    _revenueByMonth = null;
    _expensesByMonth = null;
    _netProfitOrLossByYear = null;
    _useOfFundsController.dispose();
    _sourcesOfFundsController.dispose();
    _projectedProfitAndLoss = null;
    _projectedBalanceSheet = null;
    _projectedCashFlowStatement = null;

    _profitAndLossStatementWithMonthlyDetail = null;
    _profitAndLossStatementAnnualDetail = null;
    _balanceSheetWithMonthlyDetail = null;
    _balanceSheetWithAnnualDetail = null;

    _problemSummaryController.dispose();
    _solutionSummaryController.dispose();
    _marketController.dispose();
    _competitionController.dispose();
    _whyUsController.dispose();
    _forecastController.dispose();
    _financialHighlightsByYear = null;
    _financingNeededController.dispose();
    super.dispose();
  }

  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get taglineController => _taglineController;
  TextEditingController get dateController => _dateController;
  TextEditingController get fullnameController => _fullnameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get websiteController => _websiteController;
  TextEditingController get addressController => _addressController;

  TextEditingController get problemWorthSolvingController =>
      _problemWorthSolvingController;
  TextEditingController get solutionController => _solutionController;
  TextEditingController get marketSizeAndSegmentsController =>
      _marketSizeAndSegmentsController;
  TextEditingController get currentAlternativesController =>
      _currentAlternativesController;
  TextEditingController get advantagesController => _advantagesController;

  TextEditingController get marketingPlanController => _marketingPlanController;
  TextEditingController get salesPlanController => _salesPlanController;
  TextEditingController get locationsAndFacilitiesController =>
      _locationsAndFacilitiesController;
  TextEditingController get technologyController => _technologyController;
  TextEditingController get equipmenAndToolsController =>
      _equipmenAndToolsController;
  TextEditingController get melistonesController => _melistonesController;
  TextEditingController get keyMetricsController => _keyMetricsController;

  TextEditingController get overviewController => _overviewController;
  TextEditingController get managementTeamController =>
      _managementTeamController;
  TextEditingController get advisorsController => _advisorsController;

  TextEditingController get keyAssumptionsController =>
      _keyAssumptionsController;
  File? get revenueByMonth => _revenueByMonth;
  File? get expensesByMonth => _expensesByMonth;
  File? get netProfitOrLossByYear => _netProfitOrLossByYear;
  TextEditingController get useOfFundsController => _useOfFundsController;
  TextEditingController get sourcesOfFundsController =>
      _sourcesOfFundsController;
  File? get projectedProfitAndLoss => _projectedProfitAndLoss;
  File? get projectedBalanceSheet => _projectedBalanceSheet;
  File? get projectedCashFlowStatement => _projectedCashFlowStatement;

  File? get profitAndLossStatementWithMonthlyDetail =>
      _profitAndLossStatementWithMonthlyDetail;
  File? get profitAndLossStatementAnnualDetail =>
      _profitAndLossStatementAnnualDetail;
  File? get balanceSheetWithMonthlyDetail => _balanceSheetWithMonthlyDetail;
  File? get balanceSheetWithAnnualDetail => _balanceSheetWithAnnualDetail;

  TextEditingController get problemSummaryController =>
      _problemSummaryController;
  TextEditingController get solutionSummaryController =>
      _solutionSummaryController;
  TextEditingController get marketController => _marketController;
  TextEditingController get competitionController => _competitionController;
  TextEditingController get whyUsController => _whyUsController;
  TextEditingController get forecastController => _forecastController;
  File? get financialHighlightsByYear => _financialHighlightsByYear;
  TextEditingController get financingNeededController =>
      _financingNeededController;

  void saveFrontPage() {
    // Check if all the required fields are filled
    if (_companyNameController.text.isNotEmpty &&
        _taglineController.text.isNotEmpty &&
        _fullnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _addressController.text.isNotEmpty) {
      _isFrontPageComplete = true;
    } else {
      _isFrontPageComplete = false;
    }
    notifyListeners();
  }

  void saveExecutiveSummary() {
    // Check if all the required fields are filled
    if (_problemSummaryController.text.isNotEmpty &&
        _solutionSummaryController.text.isNotEmpty &&
        _marketController.text.isNotEmpty &&
        _competitionController.text.isNotEmpty &&
        _whyUsController.text.isNotEmpty) {
      _isExecutiveSummaryComplete = true;
    } else {
      _isExecutiveSummaryComplete = false;
    }
    notifyListeners();
  }

  void saveOpportunity() {
    // Check if all the required fields are filled
    if (_problemWorthSolvingController.text.isNotEmpty &&
        _solutionController.text.isNotEmpty &&
        _marketSizeAndSegmentsController.text.isNotEmpty &&
        _currentAlternativesController.text.isNotEmpty &&
        _advantagesController.text.isNotEmpty) {
      _isOpportunityComplete = true;
    } else {
      _isOpportunityComplete = false;
    }
    notifyListeners();
  }

  void saveExecution() {
    // Check if all the required fields are filled
    if (_marketingPlanController.text.isNotEmpty &&
        _salesPlanController.text.isNotEmpty &&
        _locationsAndFacilitiesController.text.isNotEmpty &&
        _technologyController.text.isNotEmpty &&
        _equipmenAndToolsController.text.isNotEmpty &&
        _melistonesController.text.isNotEmpty &&
        _keyMetricsController.text.isNotEmpty) {
      _isExecutionComplete = true;
    } else {
      _isExecutionComplete = false;
    }
    notifyListeners();
  }

  void saveCompany() {
    // Check if all the required fields are filled
    if (_overviewController.text.isNotEmpty &&
        _managementTeamController.text.isNotEmpty &&
        _advisorsController.text.isNotEmpty) {
      _isCompanyComplete = true;
    } else {
      _isCompanyComplete = false;
    }
    notifyListeners();
  }

  void saveFinancialPlan() {
    // Check if all the required fields are filled
    if (_keyAssumptionsController.text.isNotEmpty &&
        _sourcesOfFundsController.text.isNotEmpty) {
      _isFinancialPlanComplete = true;
    } else {
      _isFinancialPlanComplete = false;
    }
    notifyListeners();
  }

  void saveAppendix() {
    _isAppendixComplete = true;
    notifyListeners();
  }

  Future<void> generatePdf(
      {required BusinessPlanMakerProvider provider}) async {
    final pdf = pw.Document();

    final dateFormat = DateFormat('MMMM d, yyyy');
    final formattedDate = dateFormat.format(DateTime.now());

    const narrowMargin = pw.EdgeInsets.all(36);

    if (isFrontPageComplete) {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.letter,
          margin: narrowMargin,
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.SizedBox(height: 40.h),
                    pw.Text(
                      'Confidential',
                      style: pw.TextStyle(
                        fontSize: 16.sp,
                        color: PdfColors.grey,
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      provider.companyNameController.text,
                      style: pw.TextStyle(
                        fontSize: 34.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Center(
                      child: pw.Text(
                        provider.taglineController.text,
                        style: pw.TextStyle(
                          fontSize: 24.sp,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 50.h),
                    pw.Text(
                      'Business Plan',
                      style: pw.TextStyle(
                        fontSize: 28.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Text(
                      // ignore: prefer_interpolation_to_compose_strings
                      'Prepared ' + formattedDate,
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(bottom: 50),
                  child: pw.Column(
                    children: [
                      pw.Text(
                        'Contact Information',
                        style: pw.TextStyle(
                          fontSize: 16.sp,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 10.h),
                      pw.Text(
                        provider.fullnameController.text,
                        style: pw.TextStyle(
                          fontSize: 11.sp,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        provider.emailController.text,
                        style: pw.TextStyle(
                          fontSize: 11.sp,
                          color: PdfColors.grey700,
                        ),
                      ),
                      pw.Text(
                        provider.phoneController.text,
                        style: pw.TextStyle(
                          fontSize: 11.sp,
                          color: PdfColors.grey700,
                        ),
                      ),
                      if (provider.websiteController.text.isNotEmpty)
                        pw.Text(
                          provider.websiteController.text,
                          style: pw.TextStyle(
                            fontSize: 11.sp,
                            color: PdfColors.grey700,
                          ),
                        ),
                      pw.Text(
                        provider.addressController.text,
                        style: pw.TextStyle(
                          fontSize: 11.sp,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.letter,
          margin: narrowMargin,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Table of Contents',
                style: pw.TextStyle(
                  fontSize: 34.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Executive Summary',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '1',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Opportunity',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.Text(
                      '1',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Expectations',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                    pw.Text(
                      '2',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ]),
              pw.SizedBox(height: 10.h),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Opportunity',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '3',
                      style: pw.TextStyle(
                        fontSize: 12.sp,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ]),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Problem & Solution',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '3',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Target Market',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '4',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Competition',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '5',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Execution',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '6',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Marketing & Sales',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '6',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Operations',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '7',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Milestones & Metrics',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '8',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Company',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '9',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Overview',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '9',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Team',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '10',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Financial Plan',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '11',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Forecast',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '11',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Financing',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '12',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Statements',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  pw.Text(
                    '13',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Appendix',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '14',
                    style: pw.TextStyle(
                      fontSize: 12.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    final financialHighlightsByYear =
        await provider.financialHighlightsByYear?.readAsBytes();
    final revenueByMonth = await provider.revenueByMonth?.readAsBytes();
    final projectedProfitAndLoss =
        await provider.projectedProfitAndLoss?.readAsBytes();
    final projectedBalanceSheet =
        await provider.projectedBalanceSheet?.readAsBytes();
    final projectedCashFlowStatement =
        await provider.projectedCashFlowStatement?.readAsBytes();
    final profitAndLossStatementWithMonthlyDetail =
        await provider.profitAndLossStatementWithMonthlyDetail?.readAsBytes();
    final profitAndLossStatementAnnualDetail =
        await provider.profitAndLossStatementAnnualDetail?.readAsBytes();
    final balanceSheetWithMonthlyDetail =
        await provider.balanceSheetWithMonthlyDetail?.readAsBytes();
    final balanceSheetWithAnnualDetail =
        await provider.balanceSheetWithAnnualDetail?.readAsBytes();
    final expensesByMonth = await provider.expensesByMonth?.readAsBytes();
    final netProfitOrLossByYear =
        await provider.netProfitOrLossByYear?.readAsBytes();

    // Load the custom Roboto font from your assets
    final ttf = await rootBundle.load("assets/fonts/Roboto-Regular.ttf");
    final roboto = pw.Font.ttf(
      ttf,
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: narrowMargin,
        build: (pw.Context context) => [
          if (_isExecutiveSummaryComplete) ...[
            pw.Text(
              'Executive Summary',
              style: pw.TextStyle(
                fontSize: 34.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Opportunity',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Problem Summary',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.problemSummaryController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Solution Summary',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.solutionSummaryController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Market',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.marketController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Competition',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.competitionController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Why Us?',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.whyUsController.text, roboto),
            pw.NewPage(),
            pw.Text(
              'Expectations',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Forecast',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.forecastController.text, roboto),
            if (financialHighlightsByYear != null) ...[
              pw.SizedBox(height: 20.h),
              pw.Text(
                'Financial Highlights by Year',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(financialHighlightsByYear),
                width: 500,
                height: 300,
              ),
            ],
            if (financingNeededController.text.isNotEmpty) ...[
              pw.SizedBox(height: 20.h),
              pw.Text(
                'Financing Needed',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              _buildFormattedText(
                  provider.financingNeededController.text, roboto),
            ],
          ],
          if (_isOpportunityComplete) ...[
            pw.NewPage(),
            pw.Text(
              'Opportunity',
              style: pw.TextStyle(
                fontSize: 34.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Problem & Solution',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Problem Worth Solving',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.problemWorthSolvingController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Our Solution',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.solutionController.text, roboto),
            pw.Text(
              'Target Market',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Market Size & Segments',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.marketSizeAndSegmentsController.text, roboto),
            pw.NewPage(),
            pw.Text(
              'Competition',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Current Alternatives',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.currentAlternativesController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Our Advantages',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.advantagesController.text, roboto),
          ],
          if (_isExecutionComplete) ...[
            pw.NewPage(),
            pw.Text(
              'Execution',
              style: pw.TextStyle(
                fontSize: 34.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Marketing & Sales',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Marketing Plan',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.marketingPlanController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Sales Plan',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.salesPlanController.text, roboto),
            pw.NewPage(),
            pw.Text(
              'Operations',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Locations & Facilities',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.locationsAndFacilitiesController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Technology',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.technologyController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Equipment & Tools',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(
                provider.equipmenAndToolsController.text, roboto),
            pw.NewPage(),
            pw.Text(
              'Milestones & Metrics',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Melistones',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.melistonesController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Key Metrics',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.keyMetricsController.text, roboto),
          ],
          if (_isCompanyComplete) ...[
            pw.NewPage(),
            pw.Text(
              'Company',
              style: pw.TextStyle(
                fontSize: 34.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Overview',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            _buildFormattedText(provider.overviewController.text, roboto),
            pw.NewPage(),
            pw.Text(
              'Team',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Management Team',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.managementTeamController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Advisors',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.advisorsController.text, roboto),
          ],
          if (_isFinancialPlanComplete) ...[
            pw.NewPage(),
            pw.Text(
              'Financial Plan',
              style: pw.TextStyle(
                fontSize: 34.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Forecast',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Key Assumptions',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.keyAssumptionsController.text, roboto),
            if (revenueByMonth != null) ...[
              pw.SizedBox(height: 20.h),
              pw.Text(
                'Revenue by Month',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  revenueByMonth,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (expensesByMonth != null) ...[
              pw.NewPage(),
              pw.Text(
                'Expenses by Month',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  expensesByMonth,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (expensesByMonth != null && netProfitOrLossByYear != null) ...[
              pw.SizedBox(height: 20.h),
            ],
            if (netProfitOrLossByYear != null) ...[
              pw.Text(
                'Net Profit (or Loss) by Year',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  netProfitOrLossByYear,
                ),
                width: 500,
                height: 300,
              ),
            ],
            pw.NewPage(),
            pw.Text(
              'Financing',
              style: pw.TextStyle(
                fontSize: 28.sp,
              ),
            ),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Use of Funds',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.useOfFundsController.text, roboto),
            pw.SizedBox(height: 20.h),
            pw.Text(
              'Sources of Funds',
              style: pw.TextStyle(
                fontSize: 14.sp,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10.h),
            _buildFormattedText(provider.sourcesOfFundsController.text, roboto),
            if (projectedProfitAndLoss != null) ...[
              pw.NewPage(),
              pw.Text(
                'Statements',
                style: pw.TextStyle(
                  fontSize: 28.sp,
                ),
              ),
              pw.SizedBox(height: 20.h),
              pw.Text(
                'Projected Profit & Loss',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  projectedProfitAndLoss,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (projectedBalanceSheet != null) ...[
              pw.NewPage(),
              pw.Text(
                'Projected Balance Sheet',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  projectedBalanceSheet,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (projectedCashFlowStatement != null) ...[
              pw.NewPage(),
              pw.Text(
                'Projected Cash Flow Statement',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  projectedCashFlowStatement,
                ),
                width: 500,
                height: 300,
              ),
            ],
          ],
          if (_isAppendixComplete) ...[
            if (profitAndLossStatementWithMonthlyDetail != null) ...[
              pw.NewPage(),
              pw.Text(
                'Appendix',
                style: pw.TextStyle(
                  fontSize: 34.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20.h),
              pw.Text(
                'Profit & Loss Statement with Monthly Detail',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  profitAndLossStatementWithMonthlyDetail,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (profitAndLossStatementAnnualDetail != null) ...[
              pw.NewPage(),
              pw.Text(
                'Profit & Loss Statement with Annual Detail',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  profitAndLossStatementAnnualDetail,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (balanceSheetWithMonthlyDetail != null) ...[
              pw.NewPage(),
              pw.Text(
                'Balance Sheet (With Monthly Detail)',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  balanceSheetWithMonthlyDetail,
                ),
                width: 500,
                height: 300,
              ),
            ],
            if (balanceSheetWithAnnualDetail != null) ...[
              pw.NewPage(),
              pw.Text(
                'Balance Sheet (With Annual Detail)',
                style: pw.TextStyle(
                  fontSize: 14.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Image(
                pw.MemoryImage(
                  balanceSheetWithAnnualDetail,
                ),
                width: 500,
                height: 300,
              ),
            ],
          ],
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/business_plan.pdf");
    await file.writeAsBytes(await pdf.save());

    // Open the generated PDF file
    OpenFile.open(file.path);
  }

  pw.Widget _buildFormattedText(String text, pw.Font roboto) {
    final lines = text.split('\n');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.trim().isEmpty) {
          return pw.SizedBox(height: 10.h);
        } else if (line.trim().startsWith('•')) {
          return pw.Bullet(
            text: line.trim().substring(1).trim(),
            style: pw.TextStyle(font: roboto, fontSize: 12.sp),
          );
        } else {
          // Convert all $ symbols to ₱
          final dollarToPesoPattern = RegExp(r'(\$[0-9,]+(\.[0-9]{2})?)');
          final formattedLine = line.splitMapJoin(
            dollarToPesoPattern,
            onMatch: (m) {
              try {
                // Convert the amount by removing $ and formatting it as Philippine pesos
                final formattedAmount = NumberFormat.simpleCurrency(
                  locale: 'en_PH',
                  name: 'PHP',
                ).format(
                  double.parse(m.group(0)!.substring(1).replaceAll(',', '')),
                );
                return formattedAmount;
              } catch (e) {
                return m[0]!;
              }
            },
            onNonMatch: (n) => n,
          );

          return pw.Text(
            formattedLine,
            style: pw.TextStyle(
              font: roboto, // Apply the custom font here
              fontSize: 12.sp,
            ),
          );
        }
      }).toList(),
    );
  }
}
