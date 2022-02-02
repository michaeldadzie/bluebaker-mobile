import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  const CustomRichText({
    required this.text1,
    required this.text2,
    required this.text3,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width.w,
      child: RichText(
        text: TextSpan(
          text: text1,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: Theme.of(context).focusColor,
          ),
          children: [
            TextSpan(
              text: text2,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Theme.of(context).hintColor,
              ),
            ),
            TextSpan(
              text: text3,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Theme.of(context).focusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
