// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:story_teller/domain/services/abstract_auth_services.dart';

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

  /// Retrieves the current authenticated user.
  ///
  /// Returns a [User] if a user is currently authenticated, otherwise null.
  @override
  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  /// Checks if a user is currently authenticated.
  ///
  /// Returns `true` if a user is authenticated, otherwise `false`.
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
        return 'The email is not valid.';
      default:
        return 'An unknown error occurred.';
    }
  }

  /// Checks if the provided email exists in the system.
  ///
  /// Returns `true` if the email exists, otherwise `false`.
  @override
  Future<bool> checkIfEmailExists(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getFirebaseAuthErrorMessage(e));
    } catch (e) {
      throw AuthException('An unknown error occurred.');
    }
  }

  /// Checks if the current user's email is verified.
  ///
  /// Returns `true` if the email is verified, otherwise `false`.
  @override
  Future<bool> checkIfUserIsVerified() async {
    final user = await getCurrentUser();
    return user?.emailVerified ?? false;
  }

  /// Sends an email verification to the current user.
  @override
  Future<void> sendEmailVerification() async {
    final user = await getCurrentUser();
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  /// Sends a password reset email to the specified email.
  ///
  /// Returns `true` on successful email dispatch, or throws an [AuthException] on failure.
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
