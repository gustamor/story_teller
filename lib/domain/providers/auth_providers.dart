import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/notifiers/auth_state_notifier.dart';
import 'package:story_teller/data/services/auth_services_impl.dart';
import 'package:story_teller/data/di/firebase_providers.dart';

/// Provider for listening to changes in the authentication state.
///
/// This provider leverages the [firebaseAuthProvider] to observe and react to changes in the user's 
/// authentication state, such as signing in or out. It emits a stream of [User] objects, where a null 
/// value indicates that the user is not signed in.
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

/// Provider for the implementation of the authentication service.
///
/// This provider creates and provides an instance of [AuthenticationServiceImpl], which is a concrete 
/// implementation of authentication operations. It utilizes the Firebase authentication instance obtained 
/// from [firebaseAuthProvider] to perform authentication tasks like user sign-in and sign-up.
final authenticationProvider = Provider<AuthenticationServiceImpl>((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthenticationServiceImpl(auth);
});

/// Authentication state notifier.
///
/// This provider offers a state notifier for authentication, encapsulated in [AuthenticationStateNotifier].
/// It manages the user's authentication state, providing functionalities like sign-in, sign-out, and 
/// registration. The notifier uses [authenticationProvider] to interact with the underlying authentication
/// service, ensuring a cohesive management of authentication states.
final authenticationStateProvider =
    StateNotifierProvider<AuthenticationStateNotifier, User?>((ref) {
  final authentication = ref.watch(authenticationProvider);
  return AuthenticationStateNotifier(authentication);
});
