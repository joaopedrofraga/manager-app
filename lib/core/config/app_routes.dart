import 'package:flutter/widgets.dart';
import 'package:manager_app/presentation/home_page.dart';

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();

  static const String initialRoute = HomePage.routeName;

  static Map<String, Widget Function(BuildContext)> get getRoutes => {
    HomePage.routeName: (context) => const HomePage(),
  };
}
