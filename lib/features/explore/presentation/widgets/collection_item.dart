import 'package:bluebaker/features/explore/presentation/pages/collections/collection_category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    required this.id,
    required this.title,
    required this.photoUrl,
    Key? key,
  }) : super(key: key);

  final String id;
  final String title;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          CollectionCategory.routeName,
          arguments: CollectionCategoryArgs(
            id: id,
            title: title,
            photoUrl: photoUrl,
          ),
        );
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                SizedBox(
                  height: 250.h,
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/load/load.gif'),
                    image: CachedNetworkImageProvider(photoUrl, scale: 1.0),
                    fadeInDuration: const Duration(milliseconds: 300),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  color: Colors.black45,
                ),
                Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  right: 20.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
