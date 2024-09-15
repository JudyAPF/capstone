import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibenture/components/food_and_beverage_tile.dart';
import 'package:ibenture/data/food_and_beverage.dart';

class FoodAndBeverageScreen extends StatelessWidget {
  FoodAndBeverageScreen({super.key});

  final foodAndBeverageList = FOOD_AND_BEVERAGE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Food & Beverages',
            textAlign: TextAlign.center,
            style: GoogleFonts.kanit(
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            )),
        centerTitle: true,
        backgroundColor: const Color(0xff311A72),
      ),
      body: ListView(
        children: foodAndBeverageList
            .map((e) => FoodAndBeverageTile(
                  food_and_beverage: e,
                ))
            .toList(),
      ),
    );
  }
}
