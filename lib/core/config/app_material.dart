import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manager_app/core/config/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppMaterial {
  static final AppMaterial _singleton = AppMaterial._internal();

  factory AppMaterial() {
    return _singleton;
  }

  AppMaterial._internal();

  static const String title = 'ManagerApp';

  static const Locale defaultLocale = Locale('pt', 'BR');

  static ThemeData get getTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    platform: TargetPlatform.windows,
    colorSchemeSeed: AppColors.primary,
    textTheme: GoogleFonts.kanitTextTheme(),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary.withValues(blue: 180),
      centerTitle: true,
      toolbarHeight: 25,
    ),
  );
}
