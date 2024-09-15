import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ibenture/data/api.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart'; // Import the file containing the BusinessPlanMakerProvider class
import 'package:provider/provider.dart';

class FrontPageProvider extends ChangeNotifier {
  List<String> aiCompanyNameSuggestions = [];
  List<String> aiTaglineSuggestions = [];
  bool isLoading = false;
  late BusinessPlanMakerProvider providerBusinessPlan;

  void initProviderBusinessPlan(BuildContext context) {
    providerBusinessPlan =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
  }

  void clearAICompanyNameSuggestions() {
    aiCompanyNameSuggestions.clear();
    notifyListeners();
  }

  Future<void> fetchAICompanyNameSuggestions(BuildContext context) async {
    isLoading = true;

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );
      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}", answer "What is your company name?". Please give me suggestions using 2 to 5 words each. Limit to 10 suggestions. Avoid using special characters, numbers, or the business type in the name. The company name should be catchy, memorable, and unique.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      // Filter the suggestions to remove empty strings, numbers, and special characters
      aiCompanyNameSuggestions = response.text!
          .split('\n')
          .where((suggestion) =>
              suggestion.trim().isNotEmpty &&
              suggestion.split(' ').length <= 5 &&
              (!suggestion.contains(providerBusinessPlan.getSelectedCategory) &&
                  (!suggestion
                      .contains(providerBusinessPlan.getSelectedSubCategory)) &&
                  (!suggestion.contains('empty'))))
          .map((suggestion) =>
              suggestion.replaceAll(RegExp(r'[0-9.]|\*|\#\#|\:'), '').trim())
          .take(10)
          .toList();

      // Debugging output to check the filtered suggestions
      for (int i = 0; i < aiCompanyNameSuggestions.length; i++) {
        // ignore: avoid_print
        print('Filtered Suggestions: ${aiCompanyNameSuggestions[i]}');
      }

      isLoading = false;

      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching AI suggestions: $e');
    }
  }

  Future<void> fetchAITaglineSuggestions() async {
    isLoading = true;

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: apiKey,
      );

      final prompt =
          'Based on the sub-category "${providerBusinessPlan.getSelectedSubCategory}" within the business type "${providerBusinessPlan.getSelectedCategory}" and the company name "${providerBusinessPlan.companyNameController.text}", answer "What is your tagline?". Please give me suggestions using 2 to 8 words each. Limit to 10 suggestions. The tagline should be catchy, memorable, and unique. Avoid using special characters, numbers, or the company name in the tagline.';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      // ignore: avoid_print
      print('AI Response: ${response.text}');

      // Filter the suggestions to remove empty strings, numbers, and special characters
      aiTaglineSuggestions = response.text!
          .split('\n')
          .where((suggestion) =>
              suggestion.trim().isNotEmpty &&
              suggestion.split(' ').length <= 8 &&
              !suggestion
                  .contains(providerBusinessPlan.companyNameController.text))
          .map((suggestion) =>
              suggestion.replaceAll(RegExp(r'[0-9.]|\*|\#\#|\:'), '').trim())
          .take(10)
          .toList();

      // ignore: avoid_print
      print('Filtered Suggestions: $aiTaglineSuggestions') ;

      isLoading = false;

      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching AI suggestions: $e');
    }
  }

  @override
  void dispose() {
    aiCompanyNameSuggestions.clear();
    aiTaglineSuggestions.clear();
    isLoading = false;
    providerBusinessPlan.dispose();
    super.dispose();
  }
}
