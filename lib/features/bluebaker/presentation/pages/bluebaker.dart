import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/bluebaker/presentation/bloc/bluebaker_bloc.dart';
import 'package:bluebaker/features/bluebaker/presentation/widgets/bluebaker_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BlueBaker extends StatefulWidget {
  const BlueBaker({Key? key}) : super(key: key);

  @override
  State<BlueBaker> createState() => _BlueBakerState();
}

class _BlueBakerState extends State<BlueBaker> {
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
              'BlueBaker',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    _buildBody(state),
                  ],
                ),
              ),
            ),
          ),
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
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          // controller: _scrollController,
          // physics: const BouncingScrollPhysics(
          //     parent: AlwaysScrollableScrollPhysics()),
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
}
