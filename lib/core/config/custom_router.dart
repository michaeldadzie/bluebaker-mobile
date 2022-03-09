import 'package:flutter/material.dart';
import '../../core/nav/page/bottom_nav_screen.dart';
import '../../core/onboarding/pages/onboard.dart';
import '../../core/screens/error.dart';
import '../../core/screens/splash.dart';
import '../../features/account/presentation/pages/account_details.dart';
import '../../features/account/presentation/pages/edit_profile.dart';
import '../../features/account/presentation/pages/privacy_policy.dart';
import '../../features/auth/presentation/pages/login.dart';
import '../../features/auth/presentation/pages/signup.dart';
import '../../features/auth/presentation/pages/welcome.dart';
import '../../features/bluebaker/presentation/pages/bluebaker/bluebaker_category.dart';
import '../../features/bluebaker/presentation/pages/bluebaker/bluebaker_life.dart';
import '../../features/explore/presentation/pages/search.dart';
import '../../features/explore/presentation/pages/search_trends.dart';
import '../../features/bluebaker/presentation/pages/videos.dart';
import '../../features/wishlist/pages/user_wishlist.dart';
import '../../features/bluebaker/presentation/pages/collections/collection_category.dart';
import '../../features/bluebaker/presentation/pages/collections.dart';
import '../../features/bluebaker/presentation/pages/collections/item_detail.dart';

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
      case PrivacyPolicy.routeName:
        return PrivacyPolicy.route();

      // Bluebaker Routes
      case BlueBakerCategory.routeName:
        return BlueBakerCategory.route(
          args: settings.arguments as BlueBakerCategoryArgs,
        );
      case BlueBakerLife.routeName:
        return BlueBakerLife.route();

      case Collections.routeName:
        return Collections.route();
      case Videos.routeName:
        return Videos.route();

      // Sub-BlueBaker Routes
      case CollectionCategory.routeName:
        return CollectionCategory.route(
          args: settings.arguments as CollectionCategoryArgs,
        );
      case ItemDetails.routeName:
        return ItemDetails.route(
          args: settings.arguments as ItemDetailsArgs,
        );

      // BlueBaker Routes
      case Search.routeName:
        return Search.route();
      case SearchTrends.routeName:
        return SearchTrends.route(
          args: settings.arguments as SearchTrendsArgs,
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
