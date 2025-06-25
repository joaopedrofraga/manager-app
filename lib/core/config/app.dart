import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manager_app/core/config/app_material.dart';
import 'package:manager_app/core/config/app_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppMaterial.title,
      theme: AppMaterial.getTheme,
      locale: AppMaterial.defaultLocale,
      routes: AppRoutes.getRoutes,
      initialRoute: AppRoutes.initialRoute,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [AppMaterial.defaultLocale],
    );
  }
}
