import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String routeName = '/privacy-policy';
  const PrivacyPolicy({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(animation),
        child: child,
      ),
      pageBuilder: (_, __, ___) => const PrivacyPolicy(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: Theme.of(context).focusColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.h),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).focusColor,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
