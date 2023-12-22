// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:story_teller/domain/services/auth_services.dart';

/// A custom exception for handling specific authentication errors.
class AuthException implements Exception {
  final String message;

  /// Initializes an [AuthException] with an error message.
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

/// Service class for authentication, interacting with [FirebaseAuth].
///
/// Provides methods for signing up, signing in, and signing out on Firebase,
/// and handles authentication errors in a customized manner.
class AuthenticationServiceImpl implements AuthenticationService {
  final FirebaseAuth _auth;

  /// Initializes a new authentication service with an instance of [FirebaseAuth].
  AuthenticationServiceImpl(this._auth);

  /// Signs in with an email and password.
  ///
  /// Returns a [User] on success or throws an [AuthException] on failure.
  @override
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    }
  }

  /// Registers a new user with email and password.
  ///
  /// Returns a [User] on success or throws an [AuthException] on failure.
  @override
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      await user?.sendEmailVerification();
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  /// Obtiene el usuario actual.
  ///
  /// Retorna un [User] si hay un usuario actualmente autenticado, de lo contrario null.
  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  /// Comprueba si el usuario está actualmente autenticado.
  ///
  /// Retorna `true` si hay un usuario autenticado, de lo contrario `false`.
  Future<bool> isUserLogged() async {
    return await getCurrentUser() != null;
  }

  /// Signs out the currently authenticated user.
  ///
  /// Returns `true` on successful sign-out, or throws an [AuthException] on failure.
  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  /// Retrieves the corresponding error message for a [FirebaseAuthException].
  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'email is no valid.';
      case 'email-already-in-use':
        return 'email is already taken';
      default:
        return 'An unknown error occurred.';
    }
  }

  @override
  Future<bool> checkIfEmailExists(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  @override
  Future<bool> checkIfUserIsVerified() async {
    final isVerified =
        await getCurrentUser().then((value) => value!.emailVerified);
    return isVerified;
  }

  @override
  Future<void> sendEmailVerification() async {
    await getCurrentUser().then((value) => value!.sendEmailVerification());
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }
}
