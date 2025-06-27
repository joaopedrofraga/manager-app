import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _singleton = AppColors._internal();

  factory AppColors() {
    return _singleton;
  }

  AppColors._internal();

  static const Color primary = Color(0xFF393997);

  static Color secundary = primary.withValues(blue: 180);

  static const Color background =
      Colors.white; //Color.fromARGB(255, 244, 244, 255);

  static const Color whiteColor = Colors.white;

  static const Color blackColor = Colors.black;

  static const Color success = Color(0xFF4CAF50);

  static const Color warning = Color(0xFFFFC107);

  static const Color error = Color(0xFFdc3545);
}
