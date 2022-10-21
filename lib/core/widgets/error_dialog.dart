import 'package:bluebaker/exports.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() tap;

  const ErrorDialog({
    Key? key,
    this.title = 'Error',
    required this.tap,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _showAndroidDialog(context, tap);
  }

  AlertDialog _showAndroidDialog(BuildContext context, Function()? tap) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        title,
        style: GoogleFonts.lato(
            color: Theme.of(context).focusColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: GoogleFonts.lato(color: Theme.of(context).focusColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: OutlinedButton(
              onPressed: tap,
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                enableFeedback: true,
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 17,
                  bottom: 17,
                ),
                primary: Theme.of(context).hintColor,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              child: Text(
                'Try again',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
