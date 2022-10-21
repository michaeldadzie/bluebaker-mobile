import 'package:bluebaker/exports.dart';

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
