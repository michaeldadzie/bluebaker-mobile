import 'package:bluebaker/exports.dart';

class ViewFullImage extends StatelessWidget {
  static const String routeName = '/image';
  const ViewFullImage({
    Key? key,
    required this.photoUrl,
  }) : super(key: key);

  final String photoUrl;

  static Route route(final String photoUrl) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ViewFullImage(
        photoUrl: photoUrl,
      ),
    );
  }

  // @override
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          children: [
            Hero(
              tag: photoUrl,
              child: FadeInImage(
                placeholder: const AssetImage('assets/load/load.gif'),
                image: CachedNetworkImageProvider(photoUrl, scale: 1.0),
                fadeInDuration: const Duration(milliseconds: 300),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
