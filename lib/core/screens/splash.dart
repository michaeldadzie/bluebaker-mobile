import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/nav/page/bottom_nav_screen.dart';
import '/features/auth/presentation/bloc/auth/auth_bloc.dart';
import '/features/auth/presentation/pages/welcome.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            //Go to Welcome Screen
            Navigator.of(context).pushNamed(WelcomeScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // Go to Bottom Nav Bar
            Future.delayed(const Duration(seconds: 0), () {
              Navigator.of(context).pushNamed(BottomNavScreen.routeName);
            });
          }
          print(state);
        },
        child: Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Colors.blue.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
