import 'exports.dart';

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
