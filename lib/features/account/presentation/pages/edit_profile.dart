import 'package:bluebaker/core/widgets/error_dialog.dart';
import 'package:bluebaker/features/account/data/models/user_model.dart';
import 'package:bluebaker/features/account/data/repositories/storage/storage_repository.dart';
import 'package:bluebaker/features/account/data/repositories/user/user_repository.dart';
import 'package:bluebaker/features/account/presentation/bloc/profile_bloc.dart';
import 'package:bluebaker/features/account/presentation/cubit/edit_profile_cubit.dart';
import 'package:bluebaker/features/account/presentation/helpers/image_helper.dart';
import 'package:bluebaker/features/account/presentation/widgets/profile_image.dart';
import 'package:bluebaker/features/auth/presentation/utils/const.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_button.dart';
import 'package:bluebaker/features/auth/presentation/widgets/custom_progress_indicator.dart';
import 'package:bluebaker/features/auth/presentation/extension/form_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

class EditProfileArgs {
  final BuildContext context;

  const EditProfileArgs({required this.context});
}

class EditProfile extends StatelessWidget {
  final User user;
  static const String routeName = '/edit';
  EditProfile({
    Key? key,
    required this.user,
  }) : super(key: key);

  static Route route({required EditProfileArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider<EditProfileCubit>(
        create: (_) => EditProfileCubit(
          userRepository: context.read<UserRepository>(),
          storageRepository: context.read<StorageRepository>(),
          profileBloc: args.context.read<ProfileBloc>(),
        ),
        child: EditProfile(
          user: args.context.read<ProfileBloc>().state.user,
        ),
      ),
    );
  }

  // final TextEditingController _name = TextEditingController();
  // final TextEditingController _username = TextEditingController();
  // final TextEditingController _country = TextEditingController();
  // final TextEditingController _telephone = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // _name.text = user.name;
    // _username.text = user.username;
    // _country.text = user.country;
    // _telephone.text = user.telephone;
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.status == EditProfileStatus.succes) {
          Navigator.of(context).pop();
        } else if (state.status == EditProfileStatus.error) {
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
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Profile',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Theme.of(context).focusColor),
              ),
              leading: state.status == EditProfileStatus.submmiting
                  ? Container()
                  : null,
              // actions: [
              //   state.status == EditProfileStatus.submmiting
              //       ? Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 20),
              //           child: Center(
              //             child: SizedBox(
              //               width: 13,
              //               height: 13,
              //               child: CircularProgressIndicator(
              //                 strokeWidth: 2,
              //                 color: Theme.of(context).focusColor,
              //               ),
              //             ),
              //           ),
              //         )
              //       : TextButton(
              //           onPressed: () {
              //             _submitForm(
              //               context,
              //               state.status == EditProfileStatus.submmiting,
              //             );
              //             print('submit');
              //           },
              //           child: Text(
              //             'DONE',
              //             style: GoogleFonts.poppins(
              //               fontSize: 15.sp,
              //               color: Theme.of(context).focusColor,
              //             ),
              //           ),
              //         ),
              // ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h.h),
                          GestureDetector(
                            onTap: () => _selectProfileImage(context),
                            child: UserProfileImage(
                              radius: 65.r,
                              profileImageUrl: user.profileImageUrl,
                              profileImage: state.profileImage,
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(height: 10.h.h),
                          Text(
                            'Add photo',
                            style: GoogleFonts.lato(
                                fontSize: 15.sp.sp,
                                color: Theme.of(context).focusColor),
                          ),
                          SizedBox(height: 20.h.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Form(
                              //TODO: Fix inital value error
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(
                                  //   'Name',
                                  //   style: GoogleFonts.lato(fontSize: 15.sp),
                                  // ),
                                  // SizedBox(height: 20.h),
                                  TextFormField(
                                    // initialValue: user.name,
                                    // textCapitalization: TextCapitalization.characters,
                                    // controller: _name,
                                    keyboardType: TextInputType.name,
                                    // onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Full name',
                                      fillColor: Theme.of(context).hoverColor,
                                    ),
                                    style: GoogleFonts.lato(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                    onChanged: (value) => context
                                        .read<EditProfileCubit>()
                                        .nameChanged(value),
                                    validator: (String? v) {
                                      if (v!.isValidName) {
                                        return null;
                                      } else {
                                        return 'Please enter a valid name';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  // Text(
                                  //   'Username',
                                  //   style: GoogleFonts.lato(fontSize: 15.sp),
                                  // ),
                                  // SizedBox(height: 20.h),
                                  TextFormField(
                                    // initialValue: user.username,
                                    // textCapitalization: TextCapitalization.characters,
                                    // controller: _username,
                                    keyboardType: TextInputType.name,
                                    // onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Username',
                                      fillColor: Theme.of(context).hoverColor,
                                    ),
                                    style: GoogleFonts.lato(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                    onChanged: (value) => context
                                        .read<EditProfileCubit>()
                                        .usernameChanged(value),
                                    validator: (String? v) {
                                      if (v!.isValidUserName) {
                                        return null;
                                      } else {
                                        return 'Please enter a valid username';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  // Text(
                                  //   'This is the name that shows on your jersey',
                                  //   style: GoogleFonts.lato(
                                  //       fontSize: 13, color: Colors.red.shade700),
                                  // ),
                                  // const SizedBox(height: 20.h),
                                  // Text(
                                  //   'Region of residence',
                                  //   style: GoogleFonts.lato(fontSize: 15.sp),
                                  // ),
                                  // SizedBox(height: 20.h),
                                  TextFormField(
                                    // initialValue: user.country,
                                    // textCapitalization: TextCapitalization.characters,
                                    // controller: _country,
                                    keyboardType: TextInputType.name,
                                    // onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Country',
                                      fillColor: Theme.of(context).hoverColor,
                                    ),
                                    style: GoogleFonts.lato(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                    onChanged: (value) => context
                                        .read<EditProfileCubit>()
                                        .countryChanged(value),
                                    validator: (String? v) {
                                      if (v!.isValidCountry) {
                                        return null;
                                      } else {
                                        return 'Please enter a valid country';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                  // Text(
                                  //   'Jersey Number',
                                  //   style: GoogleFonts.lato(fontSize: 15.sp),
                                  // ),
                                  // SizedBox(height: 20.h),
                                  TextFormField(
                                    // initialValue: user.telephone,
                                    // textCapitalization: TextCapitalization.characters,
                                    // controller: _telephone,
                                    keyboardType: TextInputType.number,
                                    // onFieldSubmitted: (_) => node.unfocus(),
                                    decoration:
                                        textFormFieldDecoration.copyWith(
                                      hintText: 'Telephone',
                                      fillColor: Theme.of(context).hoverColor,
                                    ),
                                    style: GoogleFonts.lato(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                    onChanged: (value) => context
                                        .read<EditProfileCubit>()
                                        .telephoneChanged(value),
                                    validator: (String? v) {
                                      if (v!.isValidPhone) {
                                        return null;
                                      } else {
                                        return 'Please enter a valid jersey number';
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
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
                        state.status == EditProfileStatus.submmiting
                            ? const CustomCircularProgressIndicator()
                            : CustomButton(
                                title: 'Save',
                                bordersideColor: Theme.of(context).hoverColor,
                                textColor: Theme.of(context).focusColor,
                                backgroundColor: Theme.of(context).primaryColor,
                                onPress: () {
                                  _submitForm(
                                    context,
                                    state.status ==
                                        EditProfileStatus.submmiting,
                                  );
                                  print('submit');
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
    );
  }

  void _selectProfileImage(BuildContext context) async {
    final pickedFile = await ImageHelper.pickedImageFromGallery(
      context: context,
      cropStyle: CropStyle.circle,
      title: 'Profile Image',
    );

    if (pickedFile != null) {
      context.read<EditProfileCubit>().profileImageChanged(pickedFile);
    }
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<EditProfileCubit>().submit();
    }
  }
}
