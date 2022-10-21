import 'package:bluebaker/exports.dart';

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
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Text(
            text1,
            style: GoogleFonts.raleway(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).focusColor,
            ),
            textAlign: TextAlign.start,
            maxLines: 2,
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
          ),
          child: Text(
            text2,
            style: GoogleFonts.raleway(
              fontSize: 16.sp,
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
