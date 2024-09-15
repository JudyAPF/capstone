import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/models/food_and_beverage.dart';
import 'package:ibenture/screens/permits_and_licenses_feature/food_and_beverage_category/restaurants.dart';

// ignore: must_be_immutable
class FoodAndBeverageTile extends StatefulWidget {
  // ignore: non_constant_identifier_names
  FoodAndBeverageTile({super.key, required this.food_and_beverage});

  // ignore: non_constant_identifier_names
  FoodAndBeverage food_and_beverage;

  @override
  State<FoodAndBeverageTile> createState() => _FoodAndBeverageTileState();
}

class _FoodAndBeverageTileState extends State<FoodAndBeverageTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.food_and_beverage.name == 'Restaurants') {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  const RestaurantsPermitsAndLicensesScreen()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            if (widget.food_and_beverage.image != null)
              Container(
                margin: EdgeInsets.only(bottom: 10.0.h),
                child: Image.asset(
                    'assets/images/BusinessPermitsAndLicenses/Food & Beverages.png',),
              ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                title: Text(
                  widget.food_and_beverage.name,
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                tileColor: Colors.white,
              ),
            ),
            // Gap(5.0.h),
          ],
        ),
      ),
    );
  }
}
