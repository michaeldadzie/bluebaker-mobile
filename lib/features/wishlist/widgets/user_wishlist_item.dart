import 'package:bluebaker/features/explore/presentation/pages/collections/item_detail.dart';
import 'package:bluebaker/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWishlistItem extends StatefulWidget {
  const UserWishlistItem({
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
  State<UserWishlistItem> createState() => _UserWishlistItemState();
}

class _UserWishlistItemState extends State<UserWishlistItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(
          ItemDetails.routeName,
          arguments: ItemDetailsArgs(
            id: widget.id,
            name: widget.name,
            photoUrl: widget.imageURL,
            description: widget.description,
            price: widget.price,
          ),
        )
            .then((value) {
          setState(() {
            context.read<WishlistBloc>().add(FetchWishlist());
          });
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 230.h,
            child: FadeInImage(
              placeholder: const AssetImage('assets/load/load.gif'),
              image: CachedNetworkImageProvider(widget.imageURL),
              fadeInDuration: const Duration(milliseconds: 300),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            widget.name,
            style: GoogleFonts.lato(
                color: Theme.of(context).focusColor,
                fontSize: 16.h,
                fontWeight: FontWeight.w300),
            softWrap: true,
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
          SizedBox(height: 5.h),
          Text(
            'GHC ' + widget.price,
            style: GoogleFonts.lato(
                color: Theme.of(context).focusColor,
                fontSize: 16.h,
                fontWeight: FontWeight.w300),
            softWrap: true,
            textAlign: TextAlign.left,
            maxLines: 2,
          ),
          // SizedBox(height: 5.h),
          // Text(
          //   price,
          //   style: GoogleFonts.lato(
          //       color: Theme.of(context).focusColor,
          //       fontSize: 16.h,
          //       fontWeight: FontWeight.w300),
          //   softWrap: true,
          //   textAlign: TextAlign.left,
          //   maxLines: 2,
          // ),
        ],
      ),
    );
  }
}
