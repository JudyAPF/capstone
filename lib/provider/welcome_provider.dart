import 'package:flutter/material.dart';

class WelcomeProvider extends ChangeNotifier {
  final PageController _controller = PageController();
  PageController get controller => _controller;
}