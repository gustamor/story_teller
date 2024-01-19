import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides an instance of [FirebaseAuth].
///
/// Grants access to the FirebaseAuth service, enabling user authentication and session management
/// across the entire application.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provides an instance of [FirebaseStorage].
///
/// Offers access to Firebase Storage, allowing the application to store and retrieve
/// user-generated content such as images, videos, and other files, ensuring a smooth user experience.
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

/// Provides an instance of [FirebaseFirestore].
///
/// Enables interaction with Firestore, a cloud-hosted NoSQL database, to persistently store and
/// seamlessly synchronize data across client- and server-side environments.
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provides an instance of [FirebaseRemoteConfig].
///
/// Facilitates the use of Firebase Remote Config, allowing dynamic configuration and feature
/// flagging to fine-tune and customize app behavior without deploying new versions.
final firebaseRemoteConfigProvider = Provider<FirebaseRemoteConfig>((ref) {
  return FirebaseRemoteConfig.instance;
});
