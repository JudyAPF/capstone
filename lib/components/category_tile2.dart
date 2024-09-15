// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/data/agriculture.dart';
import 'package:ibenture/data/creative.dart';
import 'package:ibenture/data/ecommerce.dart';
import 'package:ibenture/data/educational.dart';
import 'package:ibenture/data/environmental_or_green_business.dart';
import 'package:ibenture/data/financial_services.dart';
import 'package:ibenture/data/food_and_beverage.dart';
import 'package:ibenture/data/franchise_business.dart';
import 'package:ibenture/data/healthcareAndWellness.dart';
import 'package:ibenture/data/manufacturing.dart';
import 'package:ibenture/data/nonprofit_or_social_enterprise.dart';
import 'package:ibenture/data/professional_services.dart';
import 'package:ibenture/data/retail.dart';
import 'package:ibenture/data/service.dart';
import 'package:ibenture/data/technology.dart';
import 'package:ibenture/data/tourism_and_hospitality.dart';
import 'package:ibenture/data/transportation_and_logistics.dart';
import 'package:ibenture/models/category_business_permits_and_licenses.dart';
import 'package:ibenture/provider/business_plan_maker_provider.dart';
import 'package:ibenture/screens/business_plan_maker_feature/business_plan_maker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CategoryTile2 extends StatefulWidget {
  CategoryTile2({super.key, required this.category});

  CategoryBusinessPermitsAndLicenses category;

  @override
  State<CategoryTile2> createState() => _CategoryTile2State();
}

class _CategoryTile2State extends State<CategoryTile2> {
  void showSubCategory(BuildContext context, List<dynamic> category) {
    final provider =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const BusinessPlanMakerScreen(),
              ),
            );
            return true;
          },
          child: AlertDialog(
            title: Text(
              'Choose Sub-Category for ${widget.category.name}',
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
                  children: category
                      .map(
                        (subCategory) => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                subCategory.color,
                                subCategory.color.withOpacity(0.5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () {
                              provider.setSelectedSubCategory(subCategory.name);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              subCategory.name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
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
    final provider =
        Provider.of<BusinessPlanMakerProvider>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        // ignore: avoid_print
        if (widget.category.name == 'Food & Beverage') {
          final foodAndBeverage = FOOD_AND_BEVERAGE;
          showSubCategory(context, foodAndBeverage);
        } else if (widget.category.name == 'Retail') {
          final retail = RETAIL;
          showSubCategory(context, retail);
        } else if (widget.category.name == 'Service') {
          final service = SERVICE;
          showSubCategory(context, service);
        } else if (widget.category.name == 'Agriculture') {
          final agriculture = AGRICULTURE;
          showSubCategory(context, agriculture);
        } else if (widget.category.name == 'Technology') {
          final technology = TECHNOLOGY;
          showSubCategory(context, technology);
        } else if (widget.category.name == 'Creative') {
          final creative = CREATIVE;
          showSubCategory(context, creative);
        } else if (widget.category.name == 'Healthcare & Wellness') {
          final healthcareAndWellness = HEALTHCARE_AND_WELLNESS;
          showSubCategory(context, healthcareAndWellness);
        } else if (widget.category.name == 'E-commerce') {
          final eCommerece = ECOMMERCE;
          showSubCategory(context, eCommerece);
        } else if (widget.category.name == 'Professional Services') {
          final professionalServices = PROFESSIONAL_SERVICES;
          showSubCategory(context, professionalServices);
        } else if (widget.category.name == 'Franchise Business') {
          final franchiseBusiness = FRANCHISE_BUSINESS;
          showSubCategory(context, franchiseBusiness);
        } else if (widget.category.name == 'Educational') {
          final educational = EDUCATIONAL;
          showSubCategory(context, educational);
        } else if (widget.category.name == 'Manufacturing') {
          final manufacturing = MANUFACTURING;
          showSubCategory(context, manufacturing);
        } else if (widget.category.name == 'Financial Services') {
          final financialServices = FINANCIAL_SERVICES;
          showSubCategory(context, financialServices);
        } else if (widget.category.name == 'Tourism & Hospitality') {
          final tourismAndHospitality = TOURISM_AND_HOSPITALITY;
          showSubCategory(context, tourismAndHospitality);
        } else if (widget.category.name == 'Non-profit or Social Enterprise') {
          final nonProfitOrSocialEnterprise = NONPROFIT_OR_SOCIAL_ENTERPRISE;
          showSubCategory(context, nonProfitOrSocialEnterprise);
        } else if (widget.category.name == 'Transportation & Logistics') {
          final transportationAndLogistics = TRANSPORTATION_AND_LOGISTICS;
          showSubCategory(context, transportationAndLogistics);
        } else if (widget.category.name == 'Environmental Or Green Business') {
          final environmentalOrGreenBusiness = ENVIRONMENTAL_OR_GREEN_BUSINESS;
          showSubCategory(context, environmentalOrGreenBusiness);
        }
        provider.setSelectedCategory(widget.category.name);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.category.color,
              widget.category.color.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          widget.category.name,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
