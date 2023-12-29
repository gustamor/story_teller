import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/notifiers/auth_state_notifier.dart';
import 'package:story_teller/data/services/auth_services_impl.dart';
import 'package:story_teller/di/firebase_auth_provider.dart';


/// Provider for listening to changes in the authentication state.
///
/// It uses [firebaseAuthProvider] to observe changes in the user's authentication state
/// (i.e., whether the user has signed in or out).
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

/// Provider for the implementation of the authentication service.
///
/// It creates an instance of [AuthenticationServiceImpl] using [firebaseAuthProvider].
final authenticationProvider = Provider<AuthenticationServiceImpl>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthenticationServiceImpl(auth);
});

/// Authentication state notifier.
///
/// It uses [authenticationProvider] to manage the user's authentication state,
/// allowing for sign-in, sign-out, and registration.
final authenticationStateProvider =
    StateNotifierProvider<AuthenticationStateNotifier, User?>((ref) {
  final authentication = ref.watch(authenticationProvider);
  return AuthenticationStateNotifier(authentication);
});
