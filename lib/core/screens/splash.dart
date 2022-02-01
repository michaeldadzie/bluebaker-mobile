import 'package:bluebaker/core/nav/page/bottom_nav_screen.dart';
import 'package:flutter/material.dart';

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
      child: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              // Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pushNamed(BottomNavScreen.routeName);
              // });
            },
            child: CircularProgressIndicator(
              color: Colors.blue.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
