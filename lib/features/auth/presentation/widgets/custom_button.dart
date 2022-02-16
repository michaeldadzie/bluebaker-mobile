import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color bordersideColor;
  final Color? backgroundColor;
  final Color textColor;
  final double? radius;
  final double? fontsize;
  final Function() onPress;
  const CustomButton({
    required this.title,
    required this.bordersideColor,
    this.backgroundColor,
    required this.textColor,
    this.radius = 10,
    this.fontsize = 16,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: EdgeInsets.only(
            left: 18.w,
            right: 18.w,
            top: 16.h,
            bottom: 16.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!.r),
          ),
          backgroundColor: backgroundColor,
          enableFeedback: true,
          side: BorderSide(
            width: 2.w,
            color: bordersideColor,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title!,
          style: GoogleFonts.poppins(
            fontSize: fontsize!.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
