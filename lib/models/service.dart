
import 'package:flutter/material.dart';

class Service {
  const Service({
    required this.id,
    required this.name,
    this.color = const Color(0xff7e3e9c),
    this.image
  });

  final int id;
  final String name;
  final Color color;
  final String? image;
}
