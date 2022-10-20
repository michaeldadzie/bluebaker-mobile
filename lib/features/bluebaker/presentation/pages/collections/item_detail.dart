import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/presentation/pages/collections/view_full_image.dart';
import 'package:bluebaker/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDetailsArgs {
  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final String price;

  const ItemDetailsArgs({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.price,
  });
}

class ItemDetails extends StatelessWidget {
  static const String routeName = '/item-details';
  const ItemDetails({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.price,
    Key? key,
  }) : super(key: key);

  static Route route({required ItemDetailsArgs args}) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(animation),
        child: child,
      ),
      pageBuilder: (_, __, ___) => BlocProvider<WishlistBloc>(
        create: (context) => WishlistBloc(
            authBloc: context.read<AuthBloc>(),
            blueBakerRepository: context.read<BlueBakerRepository>())
          ..add(FetchWishlistItems(id: args.id)),
        child: ItemDetails(
          id: args.id,
          name: args.name,
          photoUrl: args.photoUrl,
          description: args.description,
          price: args.price,
        ),
      ),
    );
  }

  final String id;
  final String name;
  final String photoUrl;
  final String description;
  final String price;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        if (state.status == WishlistStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
              tap: () {},
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            // title: Text(
            //   name,
            //   style: GoogleFonts.poppins(
            //     fontWeight: FontWeight.w600,
            //     fontSize: 18.sp,
            //     color: Theme.of(context).focusColor,
            //   ),
            // ),
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                FeatherIcons.x,
                color: Theme.of(context).focusColor,
              ),
            ),
            // actions: [
            //   IconButton(
            //     splashColor: Colors.transparent,
            //     highlightColor: Colors.transparent,
            //     onPressed: () {
            //       state.isFavoriteItem
            //           ? context
            //               .read<WishlistBloc>()
            //               .add(RemoveItemFromWishlist(id: id))
            //           : context
            //               .read<WishlistBloc>()
            //               .add(AddItemToWishlist(id: id));
            //       state.isFavoriteItem ? Navigator.of(context).pop() : null;
            //       state.isFavoriteItem
            //           ? ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 backgroundColor: Colors.grey.shade800,
            //                 behavior: SnackBarBehavior.floating,
            //                 margin: EdgeInsets.all(20.h),
            //                 duration: const Duration(seconds: 3),
            //                 content: Text(
            //                   'Item removed from wishlist',
            //                   style: GoogleFonts.lato(
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             )
            //           : ScaffoldMessenger.of(context).showSnackBar(
            //               SnackBar(
            //                 backgroundColor: Colors.grey.shade800,
            //                 behavior: SnackBarBehavior.floating,
            //                 duration: const Duration(seconds: 3),
            //                 content: Text(
            //                   'Item added to wishlist',
            //                   style: GoogleFonts.lato(
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             );
            //     },
            //     icon: state.status == WishlistStatus.loading
            //         ? Container()
            //         : state.isFavoriteItem
            //             ? Icon(
            //                 Icons.bookmark,
            //                 size: 25.h,
            //                 color: Theme.of(context).focusColor,
            //               )
            //             : Icon(
            //                 Icons.bookmark_outline,
            //                 size: 25.h,
            //                 color: Theme.of(context).focusColor,
            //               ),
            //   )
            // ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  //TODO: Will be replaced with pageview with multiple images
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height.h,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            ViewFullImage.route(photoUrl),
                          );
                        },
                        child: Hero(
                          tag: photoUrl,
                          child: FadeInImage(
                            placeholder:
                                const AssetImage('assets/load/load.gif'),
                            image: CachedNetworkImageProvider(
                              photoUrl,
                              scale: 1.0,
                            ),
                            fadeInDuration: const Duration(milliseconds: 300),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // child: PageView.builder(
                  //   controller: _controller,
                  //   onPageChanged: (value) {
                  //     setState(() {
                  //       currentPage = value;
                  //     });
                  //   },
                  //   // physics: BouncingScrollPhysics(
                  //   //     parent: AlwaysScrollableScrollPhysics()),
                  //   itemCount: splashData.length,
                  //   itemBuilder: (context, index) => IntroContent(
                  //     image: splashData[index]['image']!,
                  //     text1: splashData[index]['text1']!,
                  //     text2: splashData[index]['text2']!,
                  //   ),
                  // ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        name,
                        style: GoogleFonts.lato(
                          color: Theme.of(context).focusColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'GHC ' + price,
                        style: GoogleFonts.lato(
                          color: Theme.of(context).focusColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        description,
                        style: GoogleFonts.lato(
                          color: Theme.of(context).focusColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: CustomButton(
                              title: 'Make Enquiry',
                              // radius: 0.r,
                              fontsize: 12.sp,
                              bordersideColor: Theme.of(context).focusColor,
                              backgroundColor: Theme.of(context).focusColor,
                              textColor: Theme.of(context).hoverColor,
                              onPress: () {},
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            flex: 1,
                            child: state.status == WishlistStatus.loading
                                ? Container(
                                    child: Container(),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.h),
                                      color: Theme.of(context).hoverColor,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      state.isFavoriteItem
                                          ? context.read<WishlistBloc>().add(
                                              RemoveItemFromWishlist(id: id))
                                          : context
                                              .read<WishlistBloc>()
                                              .add(AddItemToWishlist(id: id));
                                      state.isFavoriteItem
                                          ? Navigator.of(context).pop()
                                          : null;
                                      state.isFavoriteItem
                                          ? ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    Colors.grey.shade800,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.all(20.h),
                                                duration:
                                                    const Duration(seconds: 3),
                                                content: Text(
                                                  'Item removed from wishlist',
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(
                                                backgroundColor:
                                                    Colors.grey.shade800,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration:
                                                    const Duration(seconds: 3),
                                                content: Text(
                                                  'Item added to wishlist',
                                                  style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                    },
                                    child: Container(
                                      height: 55.h,
                                      width: 55.w,
                                      child: state.isFavoriteItem
                                          ? Icon(
                                              Icons.bookmark,
                                              color:
                                                  Theme.of(context).focusColor,
                                            )
                                          : Icon(
                                              Icons.bookmark_outline,
                                              color:
                                                  Theme.of(context).focusColor,
                                            ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.h),
                                        color: Theme.of(context).hoverColor,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
