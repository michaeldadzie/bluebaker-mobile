import 'package:bluebaker/core/config/paths.dart';
import 'package:bluebaker/features/account/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'base_user_repository.dart';


class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<User> getUserWithId({required String? userId}) async {
    final doc =
        await _firebaseFirestore.collection(Paths.users).doc(userId).get();
    return doc.exists ? User.fromDocument(doc) : User.empty;
  }

  @override
  Future<void> updateUser({required User? user}) async {
    await _firebaseFirestore
        .collection(Paths.users)
        .doc(user!.id)
        .update(user.toDocument());
  }
}
