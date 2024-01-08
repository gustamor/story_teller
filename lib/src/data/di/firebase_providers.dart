import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides an instance of [FirebaseAuth].
///
/// This provider offers access to the FirebaseAuth service throughout the application.
/// It's used to authenticate users and manage their sessions.
final firebaseAuthProvider = Provider<FirebaseAuth>((
  ref,
) {
  return FirebaseAuth.instance;
});

/// Provides an instance of [FirebaseStorage].
///
/// This provider facilitates access to Firebase Storage, enabling the application
/// to store and retrieve user-generated content like images, videos, or other files.
final firebaseStorageProvider = Provider<FirebaseStorage>((
  ref,
) {
  return FirebaseStorage.instance;
});

/// Provides an instance of [FirebaseFirestore].
///
/// This provider is used for accessing Firestore, a cloud-hosted NoSQL database,
/// to store and synchronize data for client- and server-side development.
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((
  ref,
) {
  return FirebaseFirestore.instance;
});

/// Provides an instance of [FirebaseFirestore].
///
/// Facilitates accessing and synchronizing data with the cloud-hosted NoSQL Firestore database for both client- and server-side development.
final firebaseRemoteConfigProvider = Provider<FirebaseRemoteConfig>((
  ref,
) {
  return FirebaseRemoteConfig.instance;
});
