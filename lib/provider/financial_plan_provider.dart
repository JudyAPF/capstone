import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:provider/provider.dart';

class FinancialPlanProvider extends ChangeNotifier {
  String aiKeyAssumptionsSuggestion = '';
  String aiUseOfFundsSuggestion = '';
  String aiSourcesOfFundsSuggestion = '';
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAIKeyAssumptionsSuggestion() {
    aiKeyAssumptionsSuggestion = '';
    notifyListeners();
  }

  void clearAIUseOfFundsSuggestion() {
    aiUseOfFundsSuggestion = '';
    notifyListeners();
  }

  void clearAISourcesOfFundsSuggestion() {
    aiSourcesOfFundsSuggestion = '';
    notifyListeners();
  }

  Future<void> fetchAIKeyAssumptionsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", and the "${providerBusinessPlan.overviewController.text}", and the "${providerBusinessPlan.managementTeamController.text}", and the "${providerBusinessPlan.advisorsController.text}", answer "Describe how you came up with the values in your financial forecast. Did you project your revenue based on past results, market research, your best guess at how many people visit your store and what percentage of them might buy, or some other method? What kind of growth are you assuming? What are your key hires and notable expenses? What profit level do you expect to generate?". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiKeyAssumptionsSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIUseOfFundsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", and the "${providerBusinessPlan.overviewController.text}", and the "${providerBusinessPlan.managementTeamController.text}", and the "${providerBusinessPlan.advisorsController.text}", and the "${providerBusinessPlan.keyAssumptionsController.text}", answer "If your forecast includes loans, investments, or other financing, use this space to explain what you plan to do with that money.". Approximately 150 to 250 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiUseOfFundsSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAISourcesOfFundsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", and the "${providerBusinessPlan.overviewController.text}", and the "${providerBusinessPlan.managementTeamController.text}", and the "${providerBusinessPlan.advisorsController.text}", and the "${providerBusinessPlan.keyAssumptionsController.text}", and the "${providerBusinessPlan.useOfFundsController.text}", answer "Describe your financing plans. Are you investing your own money in the business? Do you have a credit card or line of credit? What other types of funds — personal or business loans, equity investments from others, etc. — do you expect to receive and when? Understandably, you do not yet have the full details of future financing. Just explain what you do know and when you wish to sort out the details.". Approximately 150 to 250 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiSourcesOfFundsSuggestion =
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
    aiKeyAssumptionsSuggestion = '';
    aiUseOfFundsSuggestion = '';
    aiSourcesOfFundsSuggestion = '';
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }
}
