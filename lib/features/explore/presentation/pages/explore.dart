import 'package:bluebaker/features/auth/presentation/utils/const.dart';
import 'package:bluebaker/features/explore/presentation/pages/collections/collections.dart';
import 'package:bluebaker/features/explore/presentation/pages/search/search.dart';
import 'package:bluebaker/features/explore/presentation/pages/videos/videos.dart';
import 'package:bluebaker/features/explore/presentation/widgets/header_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.of(context).pushNamed(Search.routeName);
                },
                decoration: textFormFieldDecoration.copyWith(
                  hintText: 'Search BlueBaker',
                  fillColor: Theme.of(context).hoverColor,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
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
              _buildHeaderItem(),
              // SizedBox(height: 30.h),
              // _buildTrends()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderItem() {
    return SizedBox(
      height: 60.h,
      child: GridView(
        padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
        // controller: _scrollController,
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2 / 7,
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          HeaderItem(
            title: 'Collections',
            tap: () {
              Navigator.of(context).pushNamed(Collections.routeName);
            },
          ),
          HeaderItem(
            title: 'Videos',
            tap: () {
              Navigator.of(context).pushNamed(Videos.routeName);
            },
          ),
          HeaderItem(
            title: 'Editors\'s picks',
            tap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTrends() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accessories',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Swim',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Mask',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Kaftan',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Dress',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'T-Shirts',
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              color: Theme.of(context).focusColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
