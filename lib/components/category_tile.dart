import 'package:flutter/material.dart';
import 'package:ibenture/models/category_business_permits_and_licenses.dart';
import 'package:ibenture/screens/permits_and_licenses_feature/food_and_beverage.dart';

// ignore: must_be_immutable
class CategoryTile extends StatefulWidget {
  CategoryTile({super.key, required this.category});

  CategoryBusinessPermitsAndLicenses category;

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ignore: avoid_print
        if (widget.category.name == 'Food & Beverage') {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => FoodAndBeverageScreen()));
        }
        
      },
      child: Image.asset(
        widget.category.image,
        fit: BoxFit.cover,
      ),
    );
  }
}
