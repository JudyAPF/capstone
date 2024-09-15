import 'package:flutter/material.dart';

class FoodAndBeverage {
  const FoodAndBeverage({
    required this.id,
    required this.name,
    this.color = const Color(0xff4a216f),
    this.image
  });

  final int id;
  final String name;
  final Color color;
  final String? image;
}
