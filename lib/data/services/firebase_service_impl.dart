import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:story_teller/domain/services/firebase_service.dart';


@riverpod
class FirebaseServiceImpl implements FirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  late final FirebaseAuth aut;

  @override
  Future<String> signIn(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    }
  }

  @override
  Future<void> signOut() async {
    firebaseAuth.signOut();
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await user?.sendEmailVerification();
      return user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  @override
  Future<bool> isUserLogged() async {
    // ignore: unnecessary_null_comparison
    return getCurrentUser() != null;
  }
}
