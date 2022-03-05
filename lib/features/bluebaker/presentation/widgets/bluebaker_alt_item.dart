import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueBakerAltItem extends StatelessWidget {
  const BlueBakerAltItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Padding(
        padding: EdgeInsets.all(20.h),
        child: Text(
          title,
          style: GoogleFonts.lato(
            color: Theme.of(context).focusColor,
            fontSize: 18.h,
          ),
        ),
      ),
      enableFeedback: true,
      onTap: onTap,
    );
  }
}
