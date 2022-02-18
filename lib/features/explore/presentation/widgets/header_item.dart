import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem({required this.title, required this.tap, Key? key})
      : super(key: key);

  final String title;
  final void Function() tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).hoverColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontSize: 16.sp,
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
