import 'package:bluebaker/core/nav/page/bottom_nav_screen.dart';
import 'package:bluebaker/core/onboarding/pages/onboard.dart';
import 'package:bluebaker/core/screens/error.dart';
import 'package:bluebaker/core/screens/splash.dart';
import 'package:bluebaker/features/auth/presentation/pages/login.dart';
import 'package:bluebaker/features/auth/presentation/pages/signup.dart';
import 'package:bluebaker/features/auth/presentation/pages/welcome.dart';
import 'package:bluebaker/features/home/presentation/pages/settings/account.dart';
import 'package:bluebaker/features/home/presentation/pages/settings/edit_profile.dart';
import 'package:bluebaker/features/home/presentation/pages/settings.dart';
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
      case WelcomeScreen.routeName:
        return WelcomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case BottomNavScreen.routeName:
        return BottomNavScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRoute(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      // Home Routes
      case Settings.routeName:
        return Settings.route();
      // Sub-Home Routes
      case EditProfile.routeName:
        return EditProfile.route(args: settings.arguments as EditProfileArgs);
      case Account.routeName:
        return Account.route(args: settings.arguments as AccountArgs);

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
