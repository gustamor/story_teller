import 'package:firebase_auth/firebase_auth.dart';

/// Defines the contract for an authentication service.
///
/// This abstract class outlines methods for user authentication, including
/// sign-in, account creation, sign-out functionalities, email verification,
/// password reset, and user information retrieval.
abstract class AuthenticationService {
  /// Signs in a user with provided [email] and [password].
  ///
  /// After successful sign-in, it returns a [User]. If the sign-in fails,
  /// it returns `null`.
  Future<User?> signInWithEmailAndPassword(String email, String password);

  /// Creates a new user account with [email] and [password].
  ///
  /// Returns a [User] on successful account creation. Returns `null` if the
  /// account creation fails.
  Future<User?> createUserWithEmailAndPassword(String email, String password);

  /// Signs out the currently authenticated user.
  ///
  /// Returns `true` on successful sign-out. Throws an [AuthException] if
  /// the sign-out process fails.
  Future<bool> signOut();

  /// Retrieves the currently authenticated [User].
  ///
  /// Returns the authenticated [User] if available, otherwise returns `null`.
  Future<User?> getCurrentUser();

  /// Checks if the provided [email] exists in the system.
  ///
  /// Returns `true` if the [email] exists, otherwise `false`.
  Future<bool> checkIfEmailExists(String email);

  /// Checks if the current user's email is verified.
  ///
  /// Returns `true` if the email is verified, otherwise `false`.
  Future<bool> checkIfUserIsVerified();

  /// Sends an email verification to the current user.
  ///
  /// It triggers the email verification process for the current user.
  Future<void> sendEmailVerification();

  /// Sends a password reset email to the specified [email].
  ///
  /// Returns `true` on successful email dispatch. Throws an [AuthException]
  /// if the email dispatch fails.
  Future<bool> sendPasswordResetEmail(String email);

  /// Retrieves the email of the current user.
  ///
  /// Returns the email of the current user if available, otherwise `null`.
  String? getUserEmail();

  /// Sends the display name [name] to the current user's profile.
  ///
  /// It updates the display name of the current user's profile with the
  /// provided [name].
  Future<void> sendDisplayName(String name);

  /// Retrieves the display name of the current user.
  ///
  /// Returns the display name of the current user if available, otherwise `null`.
  String? getDisplayName();
}
