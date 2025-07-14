import 'package:flutter/material.dart';
import 'package:manager_app/presentation/auth/login/pages/login_page.dart';
import 'package:manager_app/presentation/auth/register/pages/register_page.dart';
import 'package:manager_app/presentation/home_page.dart';

class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();

  factory AppRoutes() {
    return _singleton;
  }

  AppRoutes._internal();

  static const String initialRoute = LoginPage.routeName;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case RegisterPage.routeName:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const RegisterPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      case HomePage.routeName:
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (_, __, ___) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(-1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 350),
        );

      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text(
                    'Erro 404: Rota "${settings.name}" não encontrada.',
                  ),
                ),
              ),
          settings: settings,
        );
    }
  }
}
