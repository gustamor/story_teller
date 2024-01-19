import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/auth_services_impl.dart';

/// State notifier for authentication.
///
/// Manages user authentication state and provides methods for signing in, signing up, and signing out.
/// Relies on [AuthenticationServiceImpl] for interactions with Firebase Auth.
class AuthenticationStateNotifier extends StateNotifier<User?> {
  final AuthenticationServiceImpl _authentication;

  /// Initializes the state notifier with the given [AuthenticationServiceImpl].
  AuthenticationStateNotifier(this._authentication) : super(null);

  /// Signs in the user using email and password.
  ///
  /// Delegates to [_authentication.signInWithEmailAndPassword] for authentication.
  /// Sets the state to the authenticated user on success, or `null` on error.
  Future<void> signIn(String email, String password) async {
    try {
      final user =
          await _authentication.signInWithEmailAndPassword(email, password);
      state = user;
    } catch (e) {
      state = null; // Consider logging or handling the sign-in error
    }
  }

  /// Registers a new user with the given email and password.
  ///
  /// Delegates to [_authentication.createUserWithEmailAndPassword] for user creation.
  /// Sets the state to the new user if the email is verified; sets to `null` otherwise or on error.
  Future<void> signUp(String email, String password) async {
    try {
      final user =
          await _authentication.createUserWithEmailAndPassword(email, password);
      if (!(user?.emailVerified ?? false)) {
        state = null; // Consider handling the unverified email case
      } else {
        state = user; // Update user state
      }
    } catch (e) {
      state = null; // Consider logging or handling the sign-up error
    }
  }

  /// Signs out the currently authenticated user.
  ///
  /// Delegates to [_authentication.signOut].
  /// Sets the state to `null` on successful sign out.
  Future<void> signOut() async {
    try {
      final success = await _authentication.signOut();
      if (success) {
        state = null;
      }
    } catch (e) {
      // Consider logging or handling the sign-out error
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

  /// Sends a password reset email to the specified email address.
  ///
  /// Returns `true` on successful email dispatch, or `false` on failure.
  Future<bool> sendPasswordResetEmail(String email) async {
    return await _authentication.sendPasswordResetEmail(email);
  }

  /// Retrieves the current user.
  ///
  /// Returns the current [User] or `null` if no user is authenticated.
  Future<User?> getCurrentUser() async {
    return await _authentication.getCurrentUser();
  }
}
