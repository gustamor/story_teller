// ignore_for_file: unused_import

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/data/network/api/firestore/model/user.dart'
    as firebase_user;

/// Provides a stream of the current Firebase user's data.
///
/// Listens to changes in the user's data within the Firebase database and
/// emits updates accordingly. In case the user data is not available or if an
/// error occurs, it emits null.
final userProvider = StreamProvider<firebase_user.User?>((ref) async* {
  final userReference = await ref.watch(fetchCurrentUserProvider.future);
  yield* userReference.snapshots().map((snapshot) => snapshot.data());
});

/// Fetches the current authenticated user's document reference from Firebase.
///
/// Accesses the Firebase Firestore instance and queries the 'users' collection
/// to retrieve the document corresponding to the current authenticated user. 
/// It ensures the user is authenticated and that the user document exists in
/// the database, throwing errors if these conditions are not met.
final fetchCurrentUserProvider =
    FutureProvider<DocumentReference<firebase_user.User?>>(
  (ref) async {
    final db = ref.watch(firebaseFirestoreProvider);
    final user = await ref.watch(authenticationProvider).getCurrentUser();

    // Ensure the user is authenticated.
    if (user == null) {
      throw Future.error("User is not authenticated.");
    }

    try {
      final collectionRef = db.collection(Collections.kUsers).withConverter(
            fromFirestore: firebase_user.User.fromFirestore,
            toFirestore: (firebase_user.User user, _) => user.toFirestore(),
          );

      // Query the database for the current user's document.
      var querySnapshot = await collectionRef
          .where('id', isEqualTo: user.uid)
          .limit(1)
          .get();

      // Return the user document reference if found, otherwise throw an error.
      if (querySnapshot.docs.isNotEmpty) {
        var userDocRef = querySnapshot.docs.first.reference;
        return userDocRef;
      } else {
        throw Future.error("User document not found.");
      }
    } catch (e) {
      // Propagate the error.
      throw Future.error("Error fetching user document: ${e.toString()}");
    }
  },
);
