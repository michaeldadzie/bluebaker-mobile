import 'package:bluebaker/core/config/custom_router.dart';
import 'package:bluebaker/core/nav/enums/bottom_nav_item.dart';
import 'package:bluebaker/features/account/data/repositories/user/user_repository.dart';
import 'package:bluebaker/features/account/presentation/bloc/profile_bloc.dart';
import 'package:bluebaker/features/account/presentation/pages/account.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/presentation/bloc/bluebaker_bloc.dart';
import 'package:bluebaker/features/bluebaker/presentation/pages/bluebaker.dart';
import 'package:bluebaker/features/explore/presentation/pages/explore.dart';
import 'package:bluebaker/features/home/presentation/pages/home.dart';
import 'package:bluebaker/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bluebaker/features/wishlist/pages/wishlist.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<BlueBakerBloc>(
              create: (context) => BlueBakerBloc(
                authBloc: context.read<AuthBloc>(),
                blueBakerRepository: context.read<BlueBakerRepository>(),
              )
                ..add(FetchCollections())
                ..add(FetchBlueBaker()),
            ),
          ],
          child: const Home(),
        );
      case BottomNavItem.explore:
        return const Explore();
      case BottomNavItem.bluebaker:
        return BlocProvider<BlueBakerBloc>(
          create: (context) => BlueBakerBloc(
            authBloc: context.read<AuthBloc>(),
            blueBakerRepository: context.read<BlueBakerRepository>(),
          )..add(
              FetchBlueBaker(),
            ),
          child: const BlueBaker(),
        );
      case BottomNavItem.wishlist:
        return MultiBlocProvider(
          providers: [
            BlocProvider<WishlistBloc>(
              create: (context) => WishlistBloc(
                authBloc: context.read<AuthBloc>(),
                blueBakerRepository: context.read<BlueBakerRepository>(),
              )..add(
                  FetchWishlist(),
                ),
            ),
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                authBloc: context.read<AuthBloc>(),
                userRepository: context.read<UserRepository>(),
              )..add(
                  ProfileLoadUser(
                    userId: context.read<AuthBloc>().state.user!.uid,
                  ),
                ),
            )
          ],
          child: const WishList(),
        );
      case BottomNavItem.account:
        return BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
          )..add(
              ProfileLoadUser(
                userId: context.read<AuthBloc>().state.user!.uid,
              ),
            ),
          child: const Account(),
        );
      default:
        return const Scaffold();
    }
  }
}
