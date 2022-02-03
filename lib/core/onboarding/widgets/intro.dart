import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '/features/auth/presentation/pages/welcome.dart';

import 'intro_content.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final PageController _controller =
      PageController(initialPage: 0, keepPage: false);
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text1": "Select Your Style",
      "text2": "From our huge collection you can chose the best one for you",
      "image": "assets/images/swim.png"
    },
    {
      "text1": "Explore BlueBaker Fashion",
      "text2": "Explore the 2021's newest fashion with our new collection",
      "image": "assets/images/mask.png"
    },
    {
      "text1": "Explore BlueBaker Fashion",
      "text2": "Explore the 2021's newest fashion with our new collection",
      "image": "assets/images/man.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            // physics: BouncingScrollPhysics(
            //     parent: AlwaysScrollableScrollPhysics()),
            itemCount: splashData.length,
            itemBuilder: (context, index) => IntroContent(
              image: splashData[index]['image']!,
              text1: splashData[index]['text1']!,
              text2: splashData[index]['text2']!,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            top: 80.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(WelcomeScreen.routeName),
                child: Text(
                  'Skip',
                  style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).focusColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  splashData.length,
                  (index) => buildDot(index: index),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    onAddButtonTapped(currentPage + 1);
                    if (currentPage == 2) {
                      Navigator.of(context).pushReplacementNamed(
                        WelcomeScreen.routeName,
                      );
                    }
                  });
                },
                child: CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Theme.of(context).focusColor,
                  child: currentPage == 2
                      ? Text(
                          'Start',
                          style: GoogleFonts.lato(
                              fontSize: 12.sp,
                              // fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          size: 15.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onAddButtonTapped(index) {
    // use this to animate to the page
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20.w : 6.w,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).focusColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }
}
