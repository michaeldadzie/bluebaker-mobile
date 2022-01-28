import '/core/onboarding/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key? key,
    required this.text1,
    required this.text2,
    required this.image,
  }) : super(key: key);
  final String text1, text2, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: Text(
            text1,
            style: GoogleFonts.raleway(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).focusColor,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(20),
          ),
          child: Text(
            text2,
            style: GoogleFonts.raleway(
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
