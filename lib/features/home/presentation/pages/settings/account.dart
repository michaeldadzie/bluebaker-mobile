import 'package:bluebaker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bluebaker/features/home/presentation/widgets/list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AccountArgs {
  final String id;
  final String email;

  const AccountArgs({
    required this.id,
    required this.email,
  });
}

class Account extends StatelessWidget {
  static const String routeName = '/account';
  const Account({
    Key? key,
    required this.id,
    required this.email,
  }) : super(key: key);

  static Route route({required AccountArgs args}) {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => Account(
        id: args.id,
        email: args.email,
      ),
    );
  }

  final String id;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: Theme.of(context).focusColor),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomListTile(
                      title: 'Username',
                      subtitle: Text(
                        id,
                        style: GoogleFonts.lato(
                            fontSize: 14.sp, color: Colors.grey.shade400),
                      ),
                    ),
                    CustomListTile(
                      title: 'Email',
                      subtitle: Text(
                        email,
                        style: GoogleFonts.lato(
                            fontSize: 14.sp, color: Colors.grey.shade400),
                      ),
                    ),
                    Text(
                      'To close (delete) your account permanently, contact customer support.',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 35.h),
                  CustomButton(
                    title: 'Log out',
                    bordersideColor: Theme.of(context).hoverColor,
                    textColor: Theme.of(context).focusColor,
                    backgroundColor: Theme.of(context).primaryColor,
                    onPress: () {
                      context.read<AuthBloc>().add(AuthLogoutRequested());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
