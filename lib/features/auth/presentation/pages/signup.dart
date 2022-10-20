import 'dart:io';

import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/auth/data/repositories/auth_repository.dart';
import 'package:bluebaker/features/auth/presentation/cubit/signup/signup_cubit.dart';
import 'package:bluebaker/features/auth/presentation/extension/form_extension.dart';
import 'package:bluebaker/features/auth/presentation/utils/const.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_progress_indicator.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_richtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<SignupCubit>(
        create: (_) =>
            SignupCubit(authRepository: context.read<AuthRepository>()),
        child: const SignupScreen(),
      ),
    );
  }

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  bool? _passwordVisible;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.status == SignupStatus.error) {
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
            appBar: AppBar(
              leading:
                  state.status == SignupStatus.submitting ? Container() : null,
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            Text(
                              'Create an account',
                              style: GoogleFonts.poppins(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            const CustomRichText(
                              text1: 'Fill in the form to start your',
                              text2: ' BlueBaker ',
                              text3: 'experience',
                            ),
                            SizedBox(height: 25.h),
                            TextFormField(
                              controller: _username,
                              keyboardType: TextInputType.name,
                              onFieldSubmitted: (_) => node.unfocus(),
                              decoration: textFormFieldDecoration.copyWith(
                                hintText: 'Fullname',
                                fillColor: Theme.of(context).hoverColor,
                              ),
                              style: GoogleFonts.lato(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).focusColor,
                              ),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .nameChanged(value),
                              validator: (String? v) {
                                if (v!.isValidName) {
                                  return null;
                                } else {
                                  return 'Please enter a valid name';
                                }
                              },
                            ),
                            SizedBox(height: 15.h),
                            TextFormField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              onFieldSubmitted: (_) => node.unfocus(),
                              decoration: textFormFieldDecoration.copyWith(
                                hintText: 'Email',
                                fillColor: Theme.of(context).hoverColor,
                              ),
                              style: GoogleFonts.lato(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).focusColor,
                              ),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .emailChanged(value),
                              validator: (String? v) {
                                if (v!.isValidEmail) {
                                  return null;
                                } else {
                                  return 'Please enter a valid email';
                                }
                              },
                            ),
                            SizedBox(height: 15.h),
                            TextFormField(
                              controller: _password,
                              obscureText: !_passwordVisible!,
                              keyboardType: TextInputType.visiblePassword,
                              onFieldSubmitted: (_) => node.unfocus(),
                              decoration: textFormFieldDecoration.copyWith(
                                hintText: 'Password',
                                fillColor: Theme.of(context).hoverColor,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible!
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).focusColor,
                                  ),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible!;
                                    });
                                  },
                                ),
                              ),
                              style: GoogleFonts.lato(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).focusColor,
                              ),
                              onChanged: (value) => context
                                  .read<SignupCubit>()
                                  .passwordChanged(value),
                              validator: (String? v) {
                                if (v!.isValidPassword) {
                                  return null;
                                } else {
                                  return 'Must be at least 8 characters';
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: Platform.isIOS ? 40.h : 20.h,
                        left: 20.w,
                        right: 20.h,
                      ),
                      child: Column(
                        children: [
                          state.status == SignupStatus.submitting
                              ? const CustomCircularProgressIndicator()
                              : CustomButton(
                                  title: 'Sign Up',
                                  bordersideColor: Theme.of(context).hintColor,
                                  textColor: Colors.white,
                                  backgroundColor: Theme.of(context).hintColor,
                                  onPress: () {
                                    _submitForm(
                                      context,
                                      state.status == SignupStatus.submitting,
                                    );
                                    // state.status == SignupStatus.success
                                    //     ? ScaffoldMessenger.of(context)
                                    //         .showSnackBar(
                                    //         SnackBar(
                                    //           backgroundColor:
                                    //               Colors.grey.shade800,
                                    //           behavior:
                                    //               SnackBarBehavior.floating,
                                    //           margin: EdgeInsets.all(20),
                                    //           duration:
                                    //               const Duration(seconds: 3),
                                    //           content: Text(
                                    //             'Welcome to BlueBaker ' +
                                    //                 state.name,
                                    //             style: GoogleFonts.lato(
                                    //               color: Colors.white,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       )
                                    //     : Container();
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<SignupCubit>().signUpWithCredentials();
    }
  }
}
