import 'package:bluebaker/features/explore/presentation/pages/search.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/error_dialog.dart';
import '../../../auth/presentation/utils/const.dart';
import '../../../bluebaker/presentation/bloc/bluebaker_bloc.dart';
import '../../../bluebaker/presentation/pages/bluebaker/bluebaker_life.dart';
import '../../../bluebaker/presentation/widgets/bluebaker_alt_item.dart';
import '../../../bluebaker/presentation/widgets/bluebaker_item.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  // late int? trend;

  // @override
  // void initState() {
  //   _loadRecentSearch();
  //   super.initState();
  // }

  // _loadRecentSearch() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     trend = prefs.getInt("trend");
  //   });
  // }

  // _addToRecentSearch(int number) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     prefs.setInt("trend", number);
  //   });
  // }

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
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            titleSpacing: 20.w,
            title: Text(
              'Explore',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: Theme.of(context).focusColor,
              ),
            ),
            bottom: AppBar(
              titleSpacing: 20.w,
              title: HeroMode(
                enabled: true,
                child: Hero(
                  tag: 'search',
                  transitionOnUserGestures: true,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Search.routeName,
                      );
                    },
                    decoration: textFormFieldDecoration.copyWith(
                      hintText: 'Search BlueBaker',
                      fillColor: Theme.of(context).hoverColor,
                      prefixIcon: Icon(
                        FeatherIcons.search,
                        color: Colors.grey.shade600,
                        size: 25.h,
                      ),
                      hintStyle: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    style: GoogleFonts.lato(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).focusColor,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 35.h),
                        _buildBody(state),
                        SizedBox(height: 35.h),
                      ],
                    ),
                  ),
                  //
                  _buildBluebakerLife(state)
                  // BlueBakerAltItem(
                  //   title: 'BlueBaker Life',
                  //   onTap: () => Navigator.of(context).pushNamed(
                  //     BlueBakerLife.routeName,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
    // Scaffold(
    //   appBar: AppBar(
    //     centerTitle: false,
    //     titleSpacing: 20.w,
    //     title: Text(
    //       'Explore',
    //       style: GoogleFonts.poppins(
    //         fontWeight: FontWeight.w600,
    //         fontSize: 22.sp,
    //         color: Theme.of(context).focusColor,
    //       ),
    //     ),
    //     bottom: AppBar(
    //       titleSpacing: 20.w,
    //       title: HeroMode(
    //         enabled: true,
    //         child: Hero(
    //           tag: 'search',
    //           transitionOnUserGestures: true,
    //           child: TextField(
    //             keyboardType: TextInputType.text,
    //             readOnly: true,
    //             onTap: () {
    //               Navigator.of(context).pushNamed(
    //                 Search.routeName,
    //               );
    //             },
    //             decoration: textFormFieldDecoration.copyWith(
    //               hintText: 'Search BlueBaker',
    //               fillColor: Theme.of(context).hoverColor,
    //               prefixIcon: Icon(
    //                 FeatherIcons.search,
    //                 color: Colors.grey.shade600,
    //                 size: 25.h,
    //               ),
    //               hintStyle: GoogleFonts.lato(
    //                 fontSize: 14.sp,
    //                 color: Colors.grey.shade600,
    //               ),
    //             ),
    //             style: GoogleFonts.lato(
    //               fontSize: 16.sp,
    //               fontWeight: FontWeight.w400,
    //               color: Theme.of(context).focusColor,
    //             ),
    //             textAlignVertical: TextAlignVertical.center,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: SafeArea(

    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Expanded(
    //           child: Padding(
    //             padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Expanded(flex: 1, child: Container()),
    //                 Expanded(
    //                   flex: 3,
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         'Trends',
    //                         style: GoogleFonts.lato(
    //                           color: Theme.of(context).focusColor,
    //                           fontSize: 18.sp,
    //                           fontWeight: FontWeight.w600,
    //                         ),
    //                       ),
    //                       Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           _trend('Dress', 1),
    //                           _trend('Mask', 2),
    //                           _trend('Shirt', 3),
    //                           _trend('Swimsuit', 4),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         // TODO: Fix Recent Search state
    //         Padding(
    //           padding: EdgeInsets.only(
    //             bottom: 40.h,
    //             left: 20.w,
    //             right: 20.w,
    //           ),
    //           child: trend == 0 || trend == null
    //               ? Container()
    //               : Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       'Recent Search',
    //                       style: GoogleFonts.lato(
    //                         color: Theme.of(context).focusColor,
    //                         fontSize: 18.sp,
    //                         fontWeight: FontWeight.w600,
    //                       ),
    //                     ),
    //                     if (trend == 1) _trend('Dress', 1),
    //                     if (trend == 2) _trend('Mask', 2),
    //                     if (trend == 3) _trend('Shirt', 3),
    //                     if (trend == 4) _trend('Swimsuit', 4),
    //                   ],
    //                 ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  // Widget _trend(String name, int number) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 20.h),
  //     child: GestureDetector(
  //       onTap: () {
  //         Navigator.of(context).pushNamed(
  //           SearchTrends.routeName,
  //           arguments: SearchTrendsArgs(
  //             id: name,
  //           ),
  //         );
  //         _addToRecentSearch(number);
  //       },
  //       child: Text(
  //         name,
  //         style: GoogleFonts.lato(
  //           color: Theme.of(context).focusColor,
  //           fontSize: 16.sp,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget _buildBody(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          // controller: _scrollController,
          itemCount: state.bluebaker.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return BlueBakerItem(
              id: state.bluebaker[index].id,
              title: state.bluebaker[index].title,
            );
          },
        );
    }
  }

  Widget _buildBluebakerLife(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Container();
      default:
        return Container(
          width: MediaQuery.of(context).size.width.w,
          color: Colors.blue.shade300,
          child: BlueBakerAltItem(
            title: 'BlueBaker Life',
            onTap: () => Navigator.of(context).pushNamed(
              BlueBakerLife.routeName,
            ),
          ),
        );
    }
  }
}
