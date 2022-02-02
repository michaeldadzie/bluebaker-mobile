import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get user;
  Future<auth.User?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required DateTime joined,
  });
  Future<auth.User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logOut();
}
