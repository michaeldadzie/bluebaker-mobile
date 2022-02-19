import 'package:bluebaker/features/bluebaker/presentation/pages/bluebaker_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueBakerItem extends StatelessWidget {
  const BlueBakerItem({
    required this.id,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: GoogleFonts.lato(
            color: Theme.of(context).focusColor,
            fontSize: 18.h,
          ),
        ),
        enableFeedback: true,
        onTap: () {
          Navigator.of(context).pushNamed(
            BlueBakerCategory.routeName,
            arguments: BlueBakerCategoryArgs(id: id),
          );
        },
      ),
    );
  }
}
