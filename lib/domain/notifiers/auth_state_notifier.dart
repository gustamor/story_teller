import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/auth_services_impl.dart';

/// State notifier for authentication.
///
/// Provides methods for signing in, signing up, and signing out. Uses
/// [AuthenticationServiceImpl] to interact with Firebase Auth.
class AuthenticationStateNotifier extends StateNotifier<User?> {
  final AuthenticationServiceImpl _authentication;

  /// Initializes the state notifier with [AuthenticationServiceImpl].
  AuthenticationStateNotifier(this._authentication) : super(null);

  /// Signs in with email and password.
  ///
  /// Uses [_authentication.signInWithEmailAndPassword] to authenticate the user.
  /// On error, sets the state to null.
  Future<void> signIn(String email, String password) async {
    try {
      final user =
          await _authentication.signInWithEmailAndPassword(email, password);
      state = user;
    } catch (e) {
      state = null;
      // Handle the sign-in error
    }
  }

  /// Registers a new user with email and password.
  ///
  /// Uses [_authentication.createUserWithEmailAndPassword] to create a new user.
  /// On error, sets the state to null.
  Future<void> signUp(String email, String password) async {
    try {
      final user =
          await _authentication.createUserWithEmailAndPassword(email, password);
      if (!(user?.emailVerified ?? false)) {
        state = null; // Handle if the email is not verified
      } else {
        state = user; // Update user state
      }
    } catch (e) {
      state = null;
      // Handle the sign-up error
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Uses [_authentication.signOut] to sign out the user.
  Future<void> signOut() async {
    try {
      final success = await _authentication.signOut();
      if (success) {
        state = null;
      }
    } catch (e) {
      // Handle the sign-out error
    }
  }

  /// Checks if a user is currently logged in.
  ///
  /// Returns `true` if a user is logged in, otherwise `false`.
  Future<bool> isUserLogged() async {
    return await _authentication.isUserLogged();
  }

  /// Checks if an email exists in the system.
  ///
  /// Returns `true` if the email exists, otherwise `false`.
  Future<bool> checkIfEmailExists(String email) async {
    return await _authentication.checkIfEmailExists(email);
  }

  /// Checks if the current user's email is verified.
  ///
  /// Returns `true` if the email is verified, otherwise `false`.
  Future<bool> checkIfUserIsVerified() async {
    return await _authentication.checkIfUserIsVerified();
  }

  /// Sends an email verification to the current user.
  Future<void> sendEmailVerification() async {
    await _authentication.sendEmailVerification();
  }

  /// Sends a password reset email to the specified email.
  ///
  /// Returns `true` on successful email dispatch, or `false` on failure.
  Future<bool> sendPasswordResetEmail(String email) async {
    return await _authentication.sendPasswordResetEmail(email);
  }
}
