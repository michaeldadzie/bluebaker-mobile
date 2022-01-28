import 'package:bluebaker/core/onboarding/utils/screen_size.dart';
import 'package:bluebaker/core/onboarding/widgets/intro.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  static const String routeName = '/onboard';
  const OnboardScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Intro(),
      ),
    );
  }
}
