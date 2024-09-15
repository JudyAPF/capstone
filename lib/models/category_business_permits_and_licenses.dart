//data class : CategoryBusinessPermitsAndLicensesBusinessPermitsAndLicenses
import 'package:flutter/material.dart';

class CategoryBusinessPermitsAndLicenses {

  const CategoryBusinessPermitsAndLicenses({
    required this.id,
    required this.name,
    this.color = Colors.purple,
    required this.image,
  });

  final int id;
  final String name;
  final Color color;
  final String image;
}