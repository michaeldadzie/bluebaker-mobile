import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/data/models/item_model.dart';
import 'package:bluebaker/features/bluebaker/presentation/bloc/bluebaker_bloc.dart';
import 'package:bluebaker/features/bluebaker/presentation/widgets/collection_category_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CollectionCategoryArgs {
  final String id;
  final String title;
  final String photoUrl;

  const CollectionCategoryArgs({
    required this.id,
    required this.title,
    required this.photoUrl,
  });
}

class CollectionCategory extends StatefulWidget {
  static const String routeName = '/collection-category';

  const CollectionCategory({
    required this.title,
    required this.id,
    required this.photoUrl,
    Key? key,
  }) : super(key: key);

  static Route route({required CollectionCategoryArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<BlueBakerBloc>(
        create: (context) => BlueBakerBloc(
          authBloc: context.read<AuthBloc>(),
          blueBakerRepository: context.read<BlueBakerRepository>(),
        )..add(FetchItems()),
        child: CollectionCategory(
          title: args.title,
          id: args.id,
          photoUrl: args.photoUrl,
        ),
      ),
    );
  }

  final String title;
  final String id;
  final String photoUrl;

  @override
  _CollectionCategoryState createState() => _CollectionCategoryState();
}

class _CollectionCategoryState extends State<CollectionCategory> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlueBakerBloc, BlueBakerState>(
      listener: (context, state) {
        // if (state.status == BlueBakerStatus.error) {
        //   showDialog(
        //     context: context,
        //     builder: (context) => ErrorDialog(
        //       content: state.failure.message,
        //       tap: () {},
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              // title: Text(
              //   'BlueBaker',
              //   style: GoogleFonts.poppins(
              //     fontWeight: FontWeight.w600,
              //     fontSize: 18.sp,
              //     color: Theme.of(context).focusColor,
              //   ),
              // ),
              ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCollectionInfo(widget.title, widget.photoUrl),
                  SizedBox(height: 20.h),
                  _buildBody(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCollectionInfo(String title, String photoUrl) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 1 / 3,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: const AssetImage('assets/load/load.gif'),
            image: CachedNetworkImageProvider(photoUrl, scale: 1.0),
            fadeInDuration: const Duration(milliseconds: 300),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
                // Text(
                //   state.items
                //       .where((item) =>
                //           item.collectionID.any((id) => id.contains(widget.id)))
                //       .toList()
                //       .length
                //       .toString(),
                //   style: GoogleFonts.lato(
                //     color: Colors.white,
                //     fontSize: 15.sp,
                //     fontWeight: FontWeight.w600,
                //   ),
                //   softWrap: true,
                //   textAlign: TextAlign.left,
                //   maxLines: 2,
                // ),
                Text(
                  title,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 30.sp,
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
    );
  }

  Widget _buildBody(BlueBakerState state) {
    List<Item> values = state.items
        .where((item) => item.collectionID.any((id) => id.contains(widget.id)))
        .toList(); //Filters the items by the collection id
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return GridView.builder(
          padding: EdgeInsets.all(20.h),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 2 / 3.6,
            maxCrossAxisExtent: 200,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          // addAutomaticKeepAlives: true,
          itemCount: values.length,
          itemBuilder: (context, index) {
            return CollectionCategoryItem(
              id: values[index].id,
              name: values[index].name,
              description: values[index].description,
              imageURL: values[index].photoUrl,
              price: values[index].price,
            );
          },
        );
    }
  }
}
