// ignore_for_file: file_names

import'package:flutter/material.dart';
class HealthcareAndWellness {
  const HealthcareAndWellness({
    required this.id,
    required this.name,
    this.color = const Color(0xff69206f),
    this.image
  });

  final int id;
  final String name;
  final Color color;
  final String? image;
}
