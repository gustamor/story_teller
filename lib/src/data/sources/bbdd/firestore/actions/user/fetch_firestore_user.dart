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

/// A provider for obtaining a [firebaseUser.User] instance.
///
/// Retrieves the currently authenticated user's data from Firestore.
/// This provider first fetches a reference to the current user's document
/// using [fetchCurrentUserProvider], then retrieves the user's data from that
/// document.
///
/// Returns a [firebaseUser.User] object if successful, or `null` if the user
/// is not found in the Firestore database.
///
/// Throws an exception if the Firestore operation fails or if the user's data
/// cannot be retrieved.
final userProvider = StreamProvider<firebaseUser.User?>((ref) async* {
  final userReference = await ref.watch(fetchCurrentUserProvider.future);
  yield* userReference.snapshots().map((snapshot) => snapshot.data());

});

/// A provider for fetching the current user's Firestore document reference.
///
/// Accesses the Firestore database to locate the document reference for the
/// current authenticated user based on their unique ID.
///
/// Utilizes [firebaseFirestoreProvider] for accessing Firestore and
/// [authenticationProvider] for obtaining the current user's details.
///
/// Returns a [DocumentReference] pointing to the user's document in Firestore.
///
/// Throws an exception if no current user is authenticated or if no document
/// is found corresponding to the user's ID in Firestore.
final fetchCurrentUserProvider =
    FutureProvider<DocumentReference<firebaseUser.User?>>(
  (ref) async {
    final db = ref.watch(firebaseFirestoreProvider);
    final user = await ref.watch(authenticationProvider).getCurrentUser();

    // Ensure the current user is not null.
    if (user == null) {
      throw Future.error("Current user is null");
    }

    try {
      final collectionRef = db.collection(Collections.kUsers).withConverter(
            fromFirestore: firebaseUser.User.fromFirestore,
            toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
          );
      var querySnapshot = await collectionRef
          .where('id', isEqualTo: user.uid)
          .limit(1)
          .get();

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
