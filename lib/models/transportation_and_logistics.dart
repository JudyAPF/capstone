import 'package:flutter/material.dart';

class TransportationAndLogistics {
  const TransportationAndLogistics({
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
