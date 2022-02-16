import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final void Function()? tap;
  final IconData? icon;
  const CustomListTile({
    required this.title,
    this.subtitle,
    this.tap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: tap,
        title: Text(
          title,
          style: GoogleFonts.lato(
              fontSize: 18.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w500),
        ),
        subtitle: subtitle,
        trailing: Icon(
          icon,
          size: 18.h,
          color: Theme.of(context).focusColor,
        ),
      ),
    );
  }
}
