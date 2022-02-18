import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/bluebaker/data/repositories/bluebaker_repository.dart';
import 'package:bluebaker/features/bluebaker/presentation/bloc/bluebaker_bloc.dart';
import 'package:bluebaker/features/explore/presentation/widgets/collection_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Collections extends StatefulWidget {
  static const String routeName = '/collections';
  const Collections({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider<BlueBakerBloc>(
        create: (context) => BlueBakerBloc(
          authBloc: context.read<AuthBloc>(),
          blueBakerRepository: context.read<BlueBakerRepository>(),
        )..add(FetchCollections()),
        child: const Collections(),
      ),
    );
  }

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
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
            title: Text(
              'Collections',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(BlueBakerState state) {
    switch (state.status) {
      case BlueBakerStatus.initial:
        return Container();
      case BlueBakerStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                // controller: _scrollController,
                // physics: const BouncingScrollPhysics(
                //     parent: AlwaysScrollableScrollPhysics()),
                itemCount: state.collections.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CollectionItem(
                    id: state.collections[index].id,
                    title: state.collections[index].title,
                    photoUrl: state.collections[index].photoUrl,
                  );
                },
              ),
            ),
          ),
        );
    }
  }
}
