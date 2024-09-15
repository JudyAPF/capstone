import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:provider/provider.dart';

class ExecutiveSummaryProvider extends ChangeNotifier {
  String aiProblemSummarySuggestion = '';
  String aiSolutionSummarySuggestion = '';
  String aiMarketSuggestion = '';
  String aiCompetitionSuggestion = '';
  String aiWhyUsSuggestion = '';
  String aiForecastSuggestion = '';
  String aiFinancingNeededSuggestion = '';
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAIProblemSummarySuggestion() {
    aiProblemSummarySuggestion = '';
    notifyListeners();
  }

  void clearAISolutionSummarySuggestion() {
    aiSolutionSummarySuggestion = '';
    notifyListeners();
  }

  void clearAIMarketSuggestion() {
    aiMarketSuggestion = '';
    notifyListeners();
  }

  void clearAICompetionSuggestion() {
    aiCompetitionSuggestion = '';
    notifyListeners();
  }

  void clearAIWhyUsSuggestion() {
    aiWhyUsSuggestion = '';
    notifyListeners();
  }

  void clearAIForecastSuggestion() {
    aiForecastSuggestion = '';
    notifyListeners();
  }

  void clearAIFinancingNeededSuggestion() {
    aiFinancingNeededSuggestion = '';
    notifyListeners();
  }

  Future<void> fetchAIProblemSummarySuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", answer "Describe very briefly why your business needs to exist. What problem do you solve for your customers?". Approximately 150 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiProblemSummarySuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAISolutionSummarySuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", answer "Briefly summarize what your company does. The executive summary should be concise, and you can go into more detail later in the plan.". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiSolutionSummarySuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAIMarketSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}", answer "Describe your target customer or market segments. Again, keep things very brief in the executive summary and add more detail later in the plan.". Approximately 150 to 200 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiMarketSuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAICompetitionSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", answer "Summarize your key competition. Who will your customers also consider?". Approximately 100 to 200 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiCompetitionSuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAIWhyUsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", answer "Write a brief overview of you and your team. Why are you the right people to build this business?". Approximately 100 to 200 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiWhyUsSuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAIForecastSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", answer "Write a brief overview of your financial targets. How much do you plan to sell next year? What are your long-term sales goals? A tool like LivePlan can help you create an automated, accurate financial forecast to include in your business plan. You can also use other software to create your financials, such as Excel or Google Sheets.". Approximately 150 to 200 words in length only. Use the Philippine peso symbol (₱) in money.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiForecastSuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }

  }

  Future<void> fetchAIFinancingNeededSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
            'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}". answer "If you are writing a business plan to raise money for your business, include a brief summary of what you are looking for. If you aren’t raising money or getting a loan, you can skip this section.". Approximately 100 to 200 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiFinancingNeededSuggestion = response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';

      } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    } 

  }

  @override
  void dispose() {
    aiProblemSummarySuggestion = '';
    aiSolutionSummarySuggestion = '';
    aiMarketSuggestion = '';
    aiCompetitionSuggestion = '';
    aiWhyUsSuggestion = '';
    aiForecastSuggestion = '';
    aiFinancingNeededSuggestion = '';
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }

}
