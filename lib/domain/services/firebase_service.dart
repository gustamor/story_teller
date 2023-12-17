import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
  Future<bool> isUserLogged();
  Future<User?> getCurrentUser();

}
