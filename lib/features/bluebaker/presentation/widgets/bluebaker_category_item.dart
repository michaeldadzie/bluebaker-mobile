import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/collections/item_detail.dart';

class BlueBakerCategoryItem extends StatelessWidget {
  const BlueBakerCategoryItem({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.imageURL,
    required this.price,
  }) : super(key: key);

  final String id;
  final String name;
  final String description;
  final String imageURL;
  final String price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemDetails.routeName,
          arguments: ItemDetailsArgs(
            id: id,
            name: name,
            description: description,
            photoUrl: imageURL,
            price: price,
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            // height: 250.h,
            width: MediaQuery.of(context).size.width.w,
            child: FadeInImage(
              placeholder: const AssetImage('assets/load/load.gif'),
              image: CachedNetworkImageProvider(imageURL),
              fadeInDuration: const Duration(milliseconds: 300),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: GoogleFonts.lato(
                      color: Theme.of(context).focusColor,
                      fontSize: 16.h,
                      fontWeight: FontWeight.w300),
                  softWrap: true,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
                Text(
                  'GHC ' + price,
                  style: GoogleFonts.lato(
                      color: Theme.of(context).focusColor,
                      fontSize: 16.h,
                      fontWeight: FontWeight.w300),
                  softWrap: true,
                  textAlign: TextAlign.left,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
