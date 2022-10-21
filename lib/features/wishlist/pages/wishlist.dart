import 'package:bluebaker/exports.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, profilestate) {},
      builder: (context, profilestate) {
        return BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, wishliststate) {},
          builder: (context, wishliststate) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                titleSpacing: 20.w,
                title: Text(
                  'Wishlist',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
              body: _buildBody(wishliststate, profilestate),
            );
          },
        );
      },
    );
  }

  Widget _buildBody(WishlistState wishliststate, ProfileState profileState) {
    switch (wishliststate.status) {
      case WishlistStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.h, right: 20.h),
              child: Column(
                children: [
                  WishlistItem(
                    tap: () {
                      Navigator.of(context)
                          .pushNamed(
                        UserWishlist.routeName,
                        arguments: UserWishlistArgs(
                          title: profileState.user.name,
                        ),
                      )
                          .then((value) {
                        setState(() {
                          context.read<WishlistBloc>().add(FetchWishlist());
                        });
                      });
                    },
                    title: profileState.user.name + '\'s List',
                    subtitle: wishliststate.items.length.toString(),
                    icon: Icons.bookmark_outline,
                  ),
                  WishlistItem(
                    tap: () {
                      // Navigator.of(context)
                      //     .pushNamed(SavedRecipes.routeName)
                      //     .then((value) {
                      //   setState(() {
                      //     context
                      //         .read<FavoriteBloc>()
                      //         .add(FetchFavoriteRecipesList());
                      //   });
                      // });
                    },
                    title: 'Saved For Later',
                    subtitle: '0',
                    icon: Icons.bookmark_outline,
                  ),
                  // ListView.builder(
                  //   padding: EdgeInsets.zero,
                  //   // controller: _scrollController,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemCount: state.meals.length,
                  //   itemBuilder: (context, index) {
                  //     // if (state.meals.isNotEmpty) {
                  //     return FavoriteRecipeItem(
                  //       id: state.meals[index].id,
                  //       name: state.meals[index].name,
                  //       description: state.meals[index].description,
                  //       imageURL: state.meals[index].photoUrl,
                  //       duration: state.meals[index].duration,
                  //     );
                  //     // }
                  //     // return Container();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
    }
  }

  // Widget _buildBody(WishlistState state) {
  //   switch (state.status) {
  //     case WishlistStatus.loading:
  //       return Center(
  //         child: CircularProgressIndicator(color: Theme.of(context).focusColor),
  //       );
  //     case WishlistStatus.error:
  //       return Center(
  //         child: Text(
  //           state.failure.message,
  //           style: GoogleFonts.lato(
  //             color: Theme.of(context).focusColor,
  //             fontSize: 18.h,
  //           ),
  //         ),
  //       );
  //     default:
  //       return Padding(
  //         padding: EdgeInsets.only(top: 10.h),
  //         child: ListView.builder(
  //           padding: EdgeInsets.only(left: 20.h, right: 20.h),
  //           // controller: _scrollController,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: state.items.length,
  //           itemBuilder: (context, index) {
  //             // if (state.items.isNotEmpty) {
  //             return ListTile(
  //               title: Text(
  //                 state.items[index].name,
  //               ),
  //             );
  //             // FavoriteRecipeItem(
  //             //   id: state.items[index].id,
  //             //   name: state.items[index].name,
  //             //   description: state.items[index].description,
  //             //   imageURL: state.items[index].photoUrl,
  //             //   duration: state.items[index].price,
  //             // );
  //             // }
  //             // return Container();
  //           },
  //         ),
  //       );
  //   }
  // }
}
