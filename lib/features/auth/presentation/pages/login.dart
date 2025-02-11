import 'dart:io';
import 'package:bluebaker/exports.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      // transitionDuration: const Duration(seconds: 0),
      builder: (context) => BlocProvider<LoginCubit>(
          create: (_) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
          child: const LoginScreen()),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
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
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
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
                  state.status == LoginStatus.submitting ? Container() : null,
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
                              'Welcome Back!',
                              style: GoogleFonts.poppins(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).focusColor,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            const CustomRichText(
                              text1: 'Sign in to your account to continue your',
                              text2: ' BlueBaker ',
                              text3: 'experience',
                            ),
                            SizedBox(height: 25.h),
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
                                  .read<LoginCubit>()
                                  .emailChanged(value),
                              validator: (String? v) {
                                if (v!.isValidEmail) {
                                  return null;
                                } else {
                                  return 'Please enter your email';
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
                                  .read<LoginCubit>()
                                  .passwordChanged(value),
                              validator: (String? v) {
                                if (v!.isValidPassword) {
                                  return null;
                                } else {
                                  return 'Please enter your password';
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
                          SizedBox(height: 35.h),
                          state.status == LoginStatus.submitting
                              ? const CustomCircularProgressIndicator()
                              : CustomButton(
                                  title: 'Continue',
                                  bordersideColor: Theme.of(context).hintColor,
                                  textColor: Colors.white,
                                  backgroundColor: Theme.of(context).hintColor,
                                  onPress: () => _submitForm(
                                    context,
                                    state.status == LoginStatus.submitting,
                                  ),
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
      context.read<LoginCubit>().logInWithCredentials();
    }
  }
}
