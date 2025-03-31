import 'package:flutter/widgets.dart';

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return {HomePage.routeName: (context) => const HomePage()};
  }
}
