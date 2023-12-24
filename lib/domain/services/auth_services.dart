import 'package:firebase_auth/firebase_auth.dart';

/// Defines the contract for an authentication service.
///
/// This abstract class outlines methods for user authentication,
/// including sign-in, account creation, and sign-out functionalities.
abstract class AuthenticationService {
  /// Signs in a user with provided [email] and [password].
  ///
  /// Returns a [User] on successful sign-in or `null` if the sign-in fails.
  Future<User?> signInWithEmailAndPassword(String email, String password);

  /// Creates a new user account with [email] and [password].
  ///
  /// Returns a [User] on successful account creation or `null` if the
  /// creation fails.
  Future<User?> createUserWithEmailAndPassword(String email, String password);

  /// Signs out the currently authenticated user.
  ///
  /// Returns `true` on successful sign-out or throws an [AuthException] on failure.
  Future<bool> signOut();

  /// Retrieves the current authenticated [User].
  ///
  /// Returns a [User] if one is currently authenticated, otherwise returns null.
  Future<User?> getCurrentUser();

  /// Checks if the provided [email] exists in the system.
  ///
  /// Returns `true` if the email exists, otherwise `false`.
  Future<bool> checkIfEmailExists(String email);

  /// Checks if the current user's email is verified.
  ///
  /// Returns `true` if the email is verified, otherwise `false`.
  Future<bool> checkIfUserIsVerified();

  /// Sends an email verification to the current user.
  Future<void> sendEmailVerification();

  /// Sends a password reset email to the specified [email].
  ///
  /// Returns `true` on successful email dispatch, otherwise throws an [AuthException].
  Future<bool> sendPasswordResetEmail(String email);
}
