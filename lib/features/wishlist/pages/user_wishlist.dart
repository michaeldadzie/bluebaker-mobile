import 'dart:developer';
import 'dart:io';

import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/presentation/widgets/collection_category_item.dart';
import 'package:bluebaker/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:bluebaker/features/wishlist/widgets/user_wishlist_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserWishlistArgs {
  final String title;

  const UserWishlistArgs({
    required this.title,
  });
}

class UserWishlist extends StatefulWidget {
  static const String routeName = '/user-wishlist';
  const UserWishlist({required this.title, Key? key}) : super(key: key);

  static Route route({required UserWishlistArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<WishlistBloc>(
        create: (context) => WishlistBloc(
          authBloc: context.read<AuthBloc>(),
          blueBakerRepository: context.read<BlueBakerRepository>(),
        )..add(FetchWishlist()),
        child: UserWishlist(
          title: args.title,
        ),
      ),
    );
  }

  final String title;

  @override
  State<UserWishlist> createState() => _UserWishlistState();
}

class _UserWishlistState extends State<UserWishlist> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              widget.title + '\'s List',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Theme.of(context).focusColor),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(WishlistState state) {
    switch (state.status) {
      case WishlistStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      case WishlistStatus.error:
        return Center(
            child: Text(
          state.failure.message,
          style: GoogleFonts.raleway(
            color: Theme.of(context).focusColor,
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ));
      default:
        return GridView.builder(
          padding: EdgeInsets.all(20.h),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: Platform.isIOS ? 2 / 3.6 : 2 / 3.2,
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            log('Items:' + state.items.length.toString());
            return UserWishlistItem(
              id: state.items[index].id,
              name: state.items[index].name,
              description: state.items[index].description,
              imageURL: state.items[index].photoUrl,
              price: state.items[index].price,
            );
          },
        );
    }
  }
}
