import 'package:bluebaker/core/nav/page/bottom_nav_screen.dart';
import 'package:bluebaker/core/onboarding/pages/onboard.dart';
import 'package:bluebaker/core/screens/error.dart';
import 'package:bluebaker/core/screens/splash.dart';
import 'package:bluebaker/features/account/presentation/pages/account_details.dart';
import 'package:bluebaker/features/account/presentation/pages/edit_profile.dart';
import 'package:bluebaker/features/auth/presentation/pages/login.dart';
import 'package:bluebaker/features/auth/presentation/pages/signup.dart';
import 'package:bluebaker/features/auth/presentation/pages/welcome.dart';
import 'package:bluebaker/features/bluebaker/presentation/pages/bluebaker_category.dart';
import 'package:bluebaker/features/explore/presentation/pages/collections/collection_category.dart';
import 'package:bluebaker/features/explore/presentation/pages/collections/item_detail.dart';
import 'package:bluebaker/features/explore/presentation/pages/search/search.dart';
import 'package:bluebaker/features/explore/presentation/pages/videos/videos.dart';
import 'package:bluebaker/features/explore/presentation/pages/collections/collections.dart';
import 'package:bluebaker/features/wishlist/pages/user_wishlist.dart';
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
      // Account Routes
      case EditProfile.routeName:
        return EditProfile.route(
          args: settings.arguments as EditProfileArgs,
        );
      case AccountDetails.routeName:
        return AccountDetails.route(
          args: settings.arguments as AccountDetailsArgs,
        );

      // Bluebaker Routes
      case BlueBakerCategory.routeName:
        return BlueBakerCategory.route(
          args: settings.arguments as BlueBakerCategoryArgs,
        );

      // Explore Routes
      case Search.routeName:
        return Search.route();
      case Collections.routeName:
        return Collections.route();
      case Videos.routeName:
        return Videos.route();

      // Sub-Explore Routes
      case CollectionCategory.routeName:
        return CollectionCategory.route(
          args: settings.arguments as CollectionCategoryArgs,
        );
      case ItemDetails.routeName:
        return ItemDetails.route(
          args: settings.arguments as ItemDetailsArgs,
        );
        
      // Wishlist Routes
      case UserWishlist.routeName:
        return UserWishlist.route(
          args: settings.arguments as UserWishlistArgs,
        );
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
