import 'dart:io';
import 'package:bluebaker/exports.dart';

class ImageHelper {
  static Future<File?> pickedImageFromGallery({
    required BuildContext context,
    required CropStyle cropStyle,
    required title,
  }) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        cropStyle: cropStyle,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: title,
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Theme.of(context).focusColor,
          backgroundColor: Theme.of(context).primaryColor,
          hideBottomControls: false,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        iosUiSettings: const IOSUiSettings(),
        compressQuality: 70,
      );
      return croppedFile;
    }
    return null;
  }
}
