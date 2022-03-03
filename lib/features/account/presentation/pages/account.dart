import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/account/presentation/bloc/profile_bloc.dart';
import 'package:bluebaker/features/account/presentation/pages/account_details.dart';
import 'package:bluebaker/features/account/presentation/pages/privacy_policy.dart';
import 'package:bluebaker/features/account/presentation/widgets/list_tile.dart';
import 'package:bluebaker/features/account/presentation/widgets/profile_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_profile.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _SettingsState();
}

class _SettingsState extends State<Account> {
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
            body: SafeArea(
          child: Column(
            children: [
              Expanded(
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
                              AccountDetails.routeName,
                              arguments: AccountDetailsArgs(
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
                          title: 'Help',
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
                          title: 'Terms Of Use',
                          icon: Icons.arrow_forward_ios_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text:
                            'At BlueBaker we take your privacy very seriously and we are commited to the protection of your personal data. Learn more about how we care for your data in our ',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w300,
                          fontSize: 13.sp,
                          color: Theme.of(context).focusColor,
                        ),
                        children: [
                          TextSpan(
                            text: 'Privacy Policy',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context)
                                  .pushNamed(PrivacyPolicy.routeName),
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              fontSize: 13.sp,
                              color: Theme.of(context).focusColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
            // SafeArea(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 20.w, right: 20.w),
            //     child: SingleChildScrollView(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           SizedBox(height: 20.h),
            //           _buildProfile(state),
            //           SizedBox(height: 30.h),
            //           CustomListTile(
            //             tap: () {
            //               Navigator.of(context).pushNamed(
            //                 AccountDetails.routeName,
            //                 arguments: AccountDetailsArgs(
            //                   id: state.user.id,
            //                   email: state.user.email,
            //                 ),
            //               );
            //             },
            //             title: 'Account',
            //             icon: Icons.arrow_forward_ios_outlined,
            //           ),
            //           SizedBox(height: 10.h),
            //           CustomListTile(
            //             tap: () {},
            //             title: 'Help',
            //             icon: Icons.arrow_forward_ios_outlined,
            //           ),
            //           SizedBox(height: 10.h),
            //           CustomListTile(
            //             tap: () {},
            //             title: 'Settings',
            //             icon: Icons.arrow_forward_ios_outlined,
            //           ),
            //           SizedBox(height: 10.h),
            //           CustomListTile(
            //             tap: () {},
            //             title: 'Terms Of Use',
            //             icon: Icons.arrow_forward_ios_outlined,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
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
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                                color: Theme.of(context).focusColor),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            state.user.email,
                            style: GoogleFonts.poppins(
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

  // void _showPrivacyPolicy(BuildContext ctx) {
  //   showModalBottomSheet(
  //     elevation: 10,
  //     backgroundColor: Theme.of(context).primaryColor,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(15.r),
  //         topRight: Radius.circular(15.r),
  //       ),
  //     ),
  //     context: ctx,
  //     builder: (ctx) => Padding(
  //       padding: EdgeInsets.only(left: 20.w, right: 20.w),
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width.w,
  //         height: MediaQuery.of(context).size.height.h,
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               SizedBox(height: 20.h),
  //               Text(
  //                 'state.user.email',
  //                 style: GoogleFonts.poppins(
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: 16.sp,
  //                   color: Colors.grey.shade600,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
