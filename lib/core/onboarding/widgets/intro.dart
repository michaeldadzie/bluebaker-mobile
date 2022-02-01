import 'package:bluebaker/core/nav/page/bottom_nav_screen.dart';

import '/core/onboarding/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              bottom: getProportionateScreenHeight(40),
              left: getProportionateScreenWidth(20),
              right: getProportionateScreenWidth(20),
              top: getProportionateScreenHeight(80)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skip',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).focusColor),
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
                        BottomNavScreen.routeName,
                      );
                    }
                  });
                },
                child: CircleAvatar(
                  radius: getProportionateScreenHeight(20),
                  backgroundColor: Theme.of(context).focusColor,
                  child: currentPage == 2
                      ? Text(
                          'Start',
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              // fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor),
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
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
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).focusColor
            : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
