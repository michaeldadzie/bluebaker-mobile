import 'package:bluebaker/features/account/data/models/user_model.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({required String userId});
  Future<void> updateUser({required User user});
}
