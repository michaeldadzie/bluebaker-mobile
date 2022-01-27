import 'package:flutter/material.dart';

class Constants {
  static String appName = "BlueBaker";

  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;

  static Color primaryGrey = Colors.grey.shade100;
  static Color secondaryGrey = Colors.grey.shade900;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimary,
      elevation: 0,
      iconTheme: IconThemeData(
        color: darkPrimary,
      ),
    ),
    // brightness: Brightness.light,
    backgroundColor: lightPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: lightPrimary),
    scaffoldBackgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    focusColor: darkPrimary,
    hoverColor: primaryGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: darkPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: lightPrimary)),
    // brightness: Brightness.dark,
    backgroundColor: darkPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: darkPrimary),
    scaffoldBackgroundColor: darkPrimary,
    primaryColor: darkPrimary,
    focusColor: lightPrimary,
    hoverColor: secondaryGrey,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );
}
