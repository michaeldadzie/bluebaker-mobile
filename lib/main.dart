import 'package:bluebaker/core/utils/screen_sizes.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/onboarding/pages/onboard.dart';
import 'core/screens/splash.dart';
import 'core/config/custom_router.dart';
import 'core/utils/theme.dart';
import 'features/account/data/repositories/storage/storage_repository.dart';
import 'features/account/data/repositories/user/user_repository.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/observer/simple_bloc_observer.dart';
import 'features/bluebaker/data/repositories/bluebaker_repository.dart';

late int? onboard;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboard = prefs.getInt("onboard");
  await prefs.setInt("onboard", 1);
  EquatableConfig.stringify = kDebugMode;
  await Firebase.initializeApp();
  Bloc.observer = SimpleClassObserver();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(
    const BlueBaker(),
  );
}

class BlueBaker extends StatelessWidget {
  const BlueBaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<StorageRepository>(
          create: (_) => StorageRepository(),
        ),
        RepositoryProvider<BlueBakerRepository>(
          create: (_) => BlueBakerRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          )
        ],
        child: ScreenUtilInit(
          designSize: Size(
            MyScreenSizes.screenWidth,
            MyScreenSizes.screenHeight,
          ),
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, widget) {
                ScreenUtil.setContext(context);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              theme: Constants.lightTheme,
              darkTheme: Constants.darkTheme,
              onGenerateRoute: CustomRouter.onGenerateRoute,
              initialRoute: onboard == 0 || onboard == null
                  ? OnboardScreen.routeName
                  : SplashScreen.routeName,
            );
          },
        ),
      ),
    );
  }
}
