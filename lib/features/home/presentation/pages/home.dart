import 'dart:async';
import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/bluebaker/presentation/bloc/bluebaker_bloc.dart';
import 'package:bluebaker/features/home/presentation/widgets/pageview_collections_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/pageview_bluebaker_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Timer _timer;

  final PageController _verticalcontroller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  final PageController _horizontalcontroller = PageController(
    initialPage: 0,
    keepPage: false,
  );

  int currentVerticalPage = 0;
  int currentHorizontalPage = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      if (currentVerticalPage < 2) {
        currentVerticalPage++;
      } else {
        currentVerticalPage = 0;
      }
      _verticalcontroller.animateToPage(
        currentVerticalPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _verticalcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlueBakerBloc, BlueBakerState>(
      listener: (context, state) {
        if (state.status == BlueBakerStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              tap: () {},
              content: state.failure.message,
            ),
          );
        }
      },
      builder: (context, state) {
        // log('Page:' + currentVerticalPage.toString());
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      currentVerticalPage == 2
                          ? Expanded(
                              flex: 1,
                              child: Container(),
                            )
                          : Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 20.h),
                            ////////// Nested PageView
                            Expanded(
                              child: PageView(
                                controller: _verticalcontroller,
                                scrollDirection: Axis.vertical,
                                onPageChanged: (value) {
                                  setState(() {
                                    currentVerticalPage = value;
                                  });
                                },
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: _buildCollectionsPageView(state),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.center,
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Expanded(
                                  //       child: PageView(
                                  //         controller: _horizontalcontroller,
                                  //         scrollDirection: Axis.horizontal,
                                  //         onPageChanged: (value) {
                                  //           setState(() {
                                  //             currentHorizontalPage = value;
                                  //           });
                                  //         },
                                  //         children: const [],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: _buildBlueBakerPageView(
                                          state,
                                          6,
                                          6,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Visit Our Store',
                                            style: GoogleFonts.raleway(
                                              fontSize: 16.sp,
                                              // fontWeight: FontWeight.bold,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        'Privacy Policy | Terms Of Use',
                                        style: GoogleFonts.raleway(
                                          fontSize: 12.sp,
                                          // fontWeight: FontWeight.bold,
                                          color: Theme.of(context).focusColor,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                      currentVerticalPage == 2
                          ? Expanded(
                              flex: 1,
                              child: Container(),
                            )
                          : Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 10.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(
                      3,
                      (index) => buildDot(index: index),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDot({int? index}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 5),
          height: 6.h,
          width: currentVerticalPage == index ? 6.w : 6.w,
          decoration: BoxDecoration(
            color: currentVerticalPage == index
                ? Theme.of(context).focusColor
                : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        SizedBox(height: 5.h),
      ],
    );
  }

  Widget _buildCollectionsPageView(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).focusColor,
          ),
        );
      default:
        return PageView.builder(
          controller: _horizontalcontroller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            setState(() {
              currentHorizontalPage = value;
            });
          },
          itemCount: state.collections.length,
          itemBuilder: (context, index) {
            return PageViewCollectionsItem(
              title: state.collections[index].title,
              photoUrl: state.collections[index].photoUrl,
              id: state.collections[index].id,
            );
          },
        );
    }
  }

  Widget _buildBlueBakerPageView(BlueBakerState state, int start, int end) {
    int startIndex = start;
    int endIndex = end;
    int itemCount = (endIndex - startIndex) + 1;
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Container();
      default:
        return PageView.builder(
          controller: _horizontalcontroller,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            setState(() {
              currentHorizontalPage = value;
            });
          },
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return PageViewBlueBakerItem(
              title: state.bluebaker[startIndex + index].title,
              photoUrl: state.bluebaker[startIndex + index].photoUrl,
              id: state.bluebaker[startIndex + index].id,
            );
          },
        );
    }
  }
}
