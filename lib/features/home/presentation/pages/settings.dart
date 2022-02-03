import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/home/data/repositories/user/user_repository.dart';
import 'package:bluebaker/features/home/presentation/bloc/profile_bloc.dart';
import 'package:bluebaker/features/home/presentation/pages/settings/account.dart';
import 'package:bluebaker/features/home/presentation/widgets/list_tile.dart';
import 'package:bluebaker/features/home/presentation/widgets/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'settings/edit_profile.dart';

class Settings extends StatefulWidget {
  static const String routeName = '/settings';
  const Settings({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (_) => BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                authBloc: context.read<AuthBloc>(),
                userRepository: context.read<UserRepository>(),
              )..add(
                  ProfileLoadUser(
                      userId: context.read<AuthBloc>().state.user!.uid),
                ),
              child: const Settings(),
            ));
  }

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
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
            title: Text(
              'Settings',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Theme.of(context).focusColor),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    _buildProfile(state),
                    SizedBox(height: 30.h),
                    CustomListTile(
                      tap: () {
                        Navigator.of(context).pushNamed(
                          Account.routeName,
                          arguments: AccountArgs(
                            id: state.user.id,
                            email: state.user.email,
                          ),
                        );
                      },
                      title: 'Account',
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                    SizedBox(height: 10.h),
                    CustomListTile(
                      tap: () {},
                      title: 'Settings',
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                    SizedBox(height: 10.h),
                    CustomListTile(
                      tap: () {},
                      title: 'Storage',
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                    SizedBox(height: 10.h),
                    CustomListTile(
                      tap: () {},
                      title: 'About',
                      icon: Icons.arrow_forward_ios_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfile(ProfileState state) {
    switch (state.status) {
      case ProfileStatus.initial:
        return Container();
      case ProfileStatus.loading:
        return Center(
          child: CircularProgressIndicator(color: Theme.of(context).focusColor),
        );
      default:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (state.isCurrentUser)
              state.user.name.isNotEmpty
                  ? GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        EditProfile.routeName,
                        arguments: EditProfileArgs(context: context),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.user.name,
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.sp,
                                color: Theme.of(context).focusColor),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            state.user.email,
                            style: GoogleFonts.raleway(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(width: 30.w),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                EditProfile.routeName,
                arguments: EditProfileArgs(context: context),
              ),
              child: UserProfileImage(
                radius: 28.r,
                profileImageUrl: state.user.profileImageUrl,
              ),
            )
          ],
        );
    }
  }
}
