import 'package:bluebaker/exports.dart';

class OnboardScreen extends StatelessWidget {
  static const String routeName = '/onboard';
  const OnboardScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnboardScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.unauthenticated) {
            //Go to Welcome Screen
            Navigator.of(context).pushNamed(OnboardScreen.routeName);
          } else if (state.status == AuthStatus.authenticated) {
            // Go to Bottom Nav Bar
            Future.delayed(const Duration(seconds: 0), () {
              Navigator.of(context).pushNamed(BottomNavScreen.routeName);
            });
          }
          print(state);
        },
        child: const Scaffold(
          body: Intro(),
        ),
      ),
    );
  }
}
