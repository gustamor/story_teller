// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart'
    as firebaseUser;

/// Provides a stream of the current Firebase user.
/// 
/// This provider listens to the user's data changes in the Firebase database
/// and emits the user data whenever it changes. If the user data is not
/// available or an error occurs, it emits null.
final userProvider = StreamProvider<firebaseUser.User?>((ref) async* {
  final userReference = await ref.watch(fetchCurrentUserProvider.future);
  yield* userReference.snapshots().map((snapshot) => snapshot.data());
});

/// A provider for fetching the current user's document reference from Firebase.
/// 
/// This provider accesses the Firebase Firestore instance and queries the 'users'
/// collection to find the document corresponding to the current authenticated user.
/// It throws an error if the user is not authenticated or if the user document
/// cannot be found in the database.
final fetchCurrentUserProvider =
    FutureProvider<DocumentReference<firebaseUser.User?>>(
  (ref) async {
    final db = ref.watch(firebaseFirestoreProvider);
    final user = await ref.watch(authenticationProvider).getCurrentUser();

    // Throws an error if the current user is null, indicating the user is not authenticated.
    if (user == null) {
      throw Future.error("Current user is null");
    }

    try {
      final collectionRef = db.collection(Collections.kUsers).withConverter(
            fromFirestore: firebaseUser.User.fromFirestore,
            toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
          );

      // Queries the database for the current user's document.
      var querySnapshot = await collectionRef
          .where('id', isEqualTo: user.uid)
          .limit(1)
          .get();

      // Returns the user document reference if found, otherwise throws an error.
      if (querySnapshot.docs.isNotEmpty) {
        var userDocRef = querySnapshot.docs.first.reference;
        return userDocRef;
      } else {
        throw Future.error("No user found");
      }
    } catch (e) {
      throw Future.error(e.toString());
    }
  },
);
