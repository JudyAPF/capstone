import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:provider/provider.dart';

class CompanyProvider extends ChangeNotifier {
  String aiOverviewSuggestion = '';
  String aiManagementTeamSuggestion = '';
  String aiAdvisorsSuggestion = '';
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAIOverviewSuggestion() {
    aiOverviewSuggestion = '';
    notifyListeners();
  }

  void clearAIManagementTeamSuggestion() {
    aiManagementTeamSuggestion = '';
    notifyListeners();
  }

  void clearAdvisorsSuggestion() {
    aiAdvisorsSuggestion = '';
    notifyListeners();
  }

  Future<void> fetchAIOverviewSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", answer "Use this area to specify who owns your company. If there are multiple owners, describe each of them and how much of an ownership stake they have. Also, identify your company’s legal structure. Is it a sole proprietorship — that is, just you  working for yourself? Or a partnership, such as a limited-liability corporation (LLC) or a partnership (LLP), where the profits pass through to the partners involved? Or a nonprofit organization? Or a proper S- or C-type corporation with its own tax obligations and the rest?". Approximately 150 to 250 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiOverviewSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIManagementTeamSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", and the "${providerBusinessPlan.overviewController.text}", answer "List the members of the management team, including yourself. Describe each person’s skills and experience and what they will be doing for the company. It’s OK if you don’t have everyone for a complete management team yet. In that case, make sure to identify gaps in your team that you intend to fill over time.". Approximately 300 to 400 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiManagementTeamSuggestion =
          response.text?.replaceAll(RegExp(r'[*#]'), '') ?? '';
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners when loading ends
    }
  }

  Future<void> fetchAIAdvisorsSuggestion(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", and the company name "${providerBusinessPlan.companyNameController.text}", and the tagline "${providerBusinessPlan.taglineController.text}", and the "${providerBusinessPlan.problemSummaryController.text}", and the "${providerBusinessPlan.solutionSummaryController.text}, and the "${providerBusinessPlan.marketController.text}", and the "${providerBusinessPlan.competitionController.text}", and the "${providerBusinessPlan.whyUsController.text}", and the "${providerBusinessPlan.forecastController.text}", and the "${providerBusinessPlan.financingNeededController.text}", and the "${providerBusinessPlan.problemWorthSolvingController.text}", and the "${providerBusinessPlan.solutionController.text}", and the "${providerBusinessPlan.marketSizeAndSegmentsController.text}", and the "${providerBusinessPlan.currentAlternativesController.text}", and the "${providerBusinessPlan.advantagesController.text}", and the "${providerBusinessPlan.marketingPlanController.text}", and the "${providerBusinessPlan.salesPlanController.text}", and the "${providerBusinessPlan.locationsAndFacilitiesController.text}", and the "${providerBusinessPlan.technologyController.text}", and the "${providerBusinessPlan.equipmenAndToolsController.text}", and the "${providerBusinessPlan.melistonesController.text}", and the "${providerBusinessPlan.keyMetricsController.text}", and the "${providerBusinessPlan.overviewController.text}", and the "${providerBusinessPlan.managementTeamController.text}", answer "Describe any mentors, investors, former professors, industry or subject-matter experts, knowledgeable friends or family members, small-business counselors, or others who can help you as a business owner.". Approximately 150 to 250 words in length only.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      aiAdvisorsSuggestion =
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
    aiOverviewSuggestion = '';
    aiManagementTeamSuggestion = '';
    aiAdvisorsSuggestion = '';
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }
}
