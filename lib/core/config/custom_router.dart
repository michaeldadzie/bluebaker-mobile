import 'package:bluebaker/core/nav/page/bottom_nav_screen.dart';
import 'package:bluebaker/core/onboarding/pages/onboard.dart';
import 'package:bluebaker/core/screens/error.dart';
import 'package:bluebaker/core/screens/splash.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case OnboardScreen.routeName:
        return OnboardScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case BottomNavScreen.routeName:
        return BottomNavScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => const ErrorScreen(),
    );
  }
}
