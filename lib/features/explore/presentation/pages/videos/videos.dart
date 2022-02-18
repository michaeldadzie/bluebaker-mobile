import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Videos extends StatelessWidget {
  static const String routeName = '/videos';
  const Videos({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const Videos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Videos',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: Theme.of(context).focusColor),
        ),
      ),
    );
  }
}
