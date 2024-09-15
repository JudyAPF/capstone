import 'package:flutter/material.dart';

class Retail {
  const Retail({
    required this.id,
    required this.name,
    this.color = const Color(0xff56288a),
    this.image
  });

  final int id;
  final String name;
  final Color color;
  final String? image;
}
