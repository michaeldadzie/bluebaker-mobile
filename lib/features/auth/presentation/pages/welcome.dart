import 'package:bluebaker/features/auth/presentation/cubit/anon/anon_cubit.dart';
import 'package:bluebaker/features/auth/presentation/pages/login.dart';
import 'package:bluebaker/features/auth/presentation/pages/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/error_dialog.dart';
import '../../data/repositories/auth_repository.dart';
import '/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      // builder: (_) => const WelcomeScreen(),
      builder: (context) => BlocProvider<AnonCubit>(
        create: (_) =>
            AnonCubit(authRepository: context.read<AuthRepository>()),
        child: const WelcomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocConsumer<AnonCubit, AnonState>(
        listener: (context, state) {
          if (state.status == AnonStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                content: state.failure.message,
                tap: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/swim.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black45,
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 20.h, left: 20.w, right: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to BlueBaker',
                              style: GoogleFonts.poppins(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Custom made garments, Ready to wear! Styling',
                              style: GoogleFonts.poppins(
                                fontSize: 15.sp,
                                color: const Color.fromRGBO(205, 205, 210, 1),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomButton(
                              title: 'Create an account',
                              bordersideColor: Theme.of(context).hintColor,
                              backgroundColor: Theme.of(context).hintColor,
                              textColor: Colors.white,
                              onPress: () {
                                Navigator.of(context)
                                    .pushNamed(SignupScreen.routeName);
                              },
                            ),
                            SizedBox(height: 20.h),
                            // Text(
                            //   'Login',
                            //   style: GoogleFonts.poppins(
                            //     fontSize: 17,
                            //     fontWeight: FontWeight.w600,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            CustomButton(
                              title: 'Login to continue',
                              bordersideColor: Colors.white,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              onPress: () {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.routeName);
                              },
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20.h,
                  left: 0.h,
                  right: 20.w,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          _loginAnonymously(
                              context, state.status == AnonStatus.submitting);
                        },
                        child: Text(
                          'Continue as guest',
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _loginAnonymously(BuildContext context, bool isSubmitting) {
    if (!isSubmitting) {
      context.read<AnonCubit>().logInAnonymously();
    }
  }
}
