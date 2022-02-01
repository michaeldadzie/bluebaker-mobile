import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/onboarding/pages/onboard.dart';
import 'core/screens/splash.dart';
import 'core/utils/screen_sizes.dart';
import 'core/config/custom_router.dart';
import 'core/utils/theme.dart';

late int? onboard;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboard = prefs.getInt("onboard");
  await prefs.setInt("onboard", 1);
  EquatableConfig.stringify = kDebugMode;
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(const BlueBaker());
}

class BlueBaker extends StatelessWidget {
  const BlueBaker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MyScreenSizes.screenWidth,
        MyScreenSizes.screenHeight,
      ),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: OnboardScreen.routeName,
          // initialRoute: onboard == 0 || onboard == null
          //     ? OnboardScreen.routeName
          //     : SplashScreen.routeName,
        );
      },
    );
  }
}
