import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:provider/provider.dart';

class ExecutionProvider extends ChangeNotifier {
  String aiMarketingPlanSuggestion = '';
  String aiSalesPlanSuggestion = '';
  String aiLocationsAndFacilitiesSuggestion = '';
  String aiTechnologySuggestion = '';
  String aiEquipmentAndToolsSuggestion = '';
  String aiMilestonesSuggestion = '';
  String aiKeyMetricsSuggestion = '';
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAIMarketingPlanSuggestion() {
    aiMarketingPlanSuggestion = '';
    notifyListeners();
  }

  void clearAISalesPlanSuggestion() {
    aiSalesPlanSuggestion = '';
    notifyListeners();
  }

  void clearAILocationsAndFacilitiesSuggestion() {
    aiLocationsAndFacilitiesSuggestion = '';
    notifyListeners();
  }

  void clearAITechnologySuggestion() {
    aiTechnologySuggestion = '';
    notifyListeners();
  }

  void clearAIEquipmentAndToolsSuggestion() {
    aiEquipmentAndToolsSuggestion = '';
    notifyListeners();
  }

  void clearAIMilestonesSuggestion() {
    aiMilestonesSuggestion = '';
    notifyListeners();
  }

  void clearAIKeyMetricsSuggestion() {
    aiKeyMetricsSuggestion = '';
    notifyListeners();
  }

  Future<void> fetchAIMarketingPlanSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", answer "Explain how you plan on getting the word out about your product to your target market(s). Will you use advertising? Perhaps you are developing a content marketing strategy. Whatever your marketing plans may be, describe them here.". Approximately 400 to 600 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiMarketingPlanSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAISalesPlanSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", answer "If your company relies on salespeople to close sales deals, you need a sales plan. Your sales plan should explain how you convert people interested in your product or service into paying customers. If you are opening a food truck, this section is less important, and you can consider removing it. However, if you are starting a sales-heavy business enterprise software or a car dealership, then you need to document how you will nurture leads and close deals.". Approximately 400 to 600 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiSalesPlanSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAILocationsAndFacilitiesSuggestion(
      BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", answer "Describe your company’s physical locations. This might be your office, store locations, manufacturing plants, storage facilities — whatever is relevant to your business. How much space do you have available, and how well will it meet your current and future needs?". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiLocationsAndFacilitiesSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAITechnologySuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", answer "Describe any important software, hardware, or other information technology that you use now or plan to use later to operate your business. That might include a point-of-sale system to take payments, an e-commerce engine for your website, a CRM solution for managing your pipeline, marketing tools for generating leads, and so on.". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiTechnologySuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIEquipmentAndToolsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", answer "List any specialty equipment that you have or plan to acquire to do your work. This is an important component of the business plan for many industrial companies.". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiEquipmentAndToolsSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIMilestonesSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", answer "List your key milestones and the dates that you hope to accomplish them. If you’ve already accomplished key goals for your business, list them here as evidence that your business is getting traction – in other words, it’s getting positive attention from potential customers.". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiMilestonesSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIKeyMetricsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", answer "Explain which performance metrics are most important for understanding how your business is doing. What does success mean for you, and how will you know it when you see it?". Approximately 200 to 300 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiKeyMetricsSuggestion =
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
    aiMarketingPlanSuggestion = '';
    aiSalesPlanSuggestion = '';
    aiLocationsAndFacilitiesSuggestion = '';
    aiTechnologySuggestion = '';
    aiEquipmentAndToolsSuggestion = '';
    aiMilestonesSuggestion = '';
    aiKeyMetricsSuggestion = '';
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }
}
