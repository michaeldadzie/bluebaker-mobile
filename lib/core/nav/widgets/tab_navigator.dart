import 'package:bluebaker/core/config/custom_router.dart';
import 'package:bluebaker/core/nav/enums/bottom_nav_item.dart';
import 'package:bluebaker/features/explore/explore.dart';
import 'package:bluebaker/features/home/home.dart';
import 'package:bluebaker/features/wishlist/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TabNavigator extends StatelessWidget {
  static const String? tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState>? navigatorKey;
  final BottomNavItem? item;

  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: const RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilders![initialRoute]!(context),
          )
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String?, WidgetBuilder?>? _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreen(context, item)};
  }

  Widget _getScreen(BuildContext context, BottomNavItem? item) {
    switch (item) {
      case BottomNavItem.home:
        return const Home();
      case BottomNavItem.explore:
         return const Explore();
      case BottomNavItem.wishlist:
         return const WishList();
      default:
        return const Scaffold();
    }
  }
}
