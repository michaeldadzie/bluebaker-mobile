import 'dart:io';
import 'package:bluebaker/exports.dart';
import 'base_storage_repository.dart';

class StorageRepository extends BaseStorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<String> _uploadImage({
    required File image,
    required String ref,
  }) async {
    final downloadUrl = await _firebaseStorage
        .ref(ref)
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
    return downloadUrl;
  }

  @override
  Future<String> uploadProfileImage({
    required String url,
    required File image,
  }) async {
    var imageId = const Uuid().v4();

    if (url.isNotEmpty) {
      final exp = RegExp(r'userProfile_(.*).jpg');
      // final exp = RegExp(r'/[\w-]+\.(jpg|png)/g');
      imageId = exp.firstMatch(url)![1]!;
    }

    final downloadUrl = await _uploadImage(
      image: image,
      ref: 'images/users/userProfile_$imageId.jpg',
    );
    return downloadUrl;
  }
}
