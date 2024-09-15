// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:provider/provider.dart';

class OpportunityProvider extends ChangeNotifier {
  String aiProblemWorthSolvingSuggestion = '';
  String aiOurSolutionSuggestion = '';
  String aiMarketSizeAndSegmentsSuggestion = '';
  String aiCurrentAlternativesSuggestion = '';
  String aiOurAdvantagesSuggestion = '';
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAIProblemWorthSolvingSuggestion() {
    aiProblemWorthSolvingSuggestion = '';
    notifyListeners();
  }

  void clearAIOurSolutionSuggestion() {
    aiOurSolutionSuggestion = '';
    notifyListeners();
  }

  void clearAIMarketSizeAndSegmentsSuggestion() {
    aiMarketSizeAndSegmentsSuggestion = '';
    notifyListeners();
  }

  void clearAICurrentAlternativesSuggestion() {
    aiCurrentAlternativesSuggestion = '';
    notifyListeners();
  }

  void clearAIOurAdvantagesSuggestion() {
    aiOurAdvantagesSuggestion = '';
    notifyListeners();
  }

  Future<void> fetchAIProblemWorthSolvingSuggestion(
      BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", answer "Write more details about the problem you are solving than you provided in the executive summary. What do your customers need? Do they need a better product, a cheaper product, or just a store in a better location? Describe why customers will want to buy from you.". Approximately 300 to 500 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiProblemWorthSolvingSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIOurSolutionSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", answer "Provide additional detail, beyond what you wrote in the Executive Summary, about your product or service. What is unique and special about your company that’s going to set it apart from the competition?". Approximately 300 to 500 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiOurSolutionSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIMarketSizeAndSegmentsSuggestion(
      BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", answer "Describe your key customers – who they are and what their key attributes are. If your company is targeting multiple customer groups (also called ‘segments’), describe each group here. If you can, include details about how many people are in each segment and how large the total market is. The more specific you can be about your target market, the better.". Approximately 300 to 500 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiMarketSizeAndSegmentsSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAICurrentAlternativesSuggestion(
      BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", answer "Describe your current alternatives. Who are your competitors? What are the alternatives to your product or service? What are customers currently doing to solve the problem you are solving?". Approximately 300 to 500 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiCurrentAlternativesSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIOurAdvantagesSuggestion(
      BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", answer "Describe your competitive advantages. What makes your company special? Why will customers choose you over your competitors? What are the key things that you will do to make your product or service stand out?". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiOurAdvantagesSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
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
    aiProblemWorthSolvingSuggestion = '';
    aiOurSolutionSuggestion = '';
    aiMarketSizeAndSegmentsSuggestion = '';
    aiCurrentAlternativesSuggestion = '';
    aiOurAdvantagesSuggestion = '';
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }
}
