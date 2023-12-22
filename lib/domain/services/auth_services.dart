import 'package:firebase_auth/firebase_auth.dart';

/// This abstract class defines the contract for an authentication service.
///
/// It provides methods for user authentication such as signing in and
/// creating a new user account.
abstract class AuthenticationService {
  /// Signs in a user with the provided [email] and [password].
  ///
  /// Returns a [User] object on successful sign-in or `null` if the sign-in fails.
  Future<User?> signInWithEmailAndPassword(String email, String password);

  /// Creates a new user account with the provided [email] and [password].
  ///
  /// Returns a [User] object on successful account creation or `null` if the
  /// creation fails.
  Future<User?> createUserWithEmailAndPassword(String email, String password);

  /// Signs out the currently authenticated user.
  ///
  /// Returns `true` on successful sign-out, or throws an [AuthException] on failure.
  Future<bool> signOut();

  Future<User?> getCurrentUser();

  Future<bool> checkIfEmailExists(String email);

  Future<bool> checkIfUserIsVerified();

  Future<void> sendEmailVerification();

  Future<bool> sendPasswordResetEmail(String email);
}
