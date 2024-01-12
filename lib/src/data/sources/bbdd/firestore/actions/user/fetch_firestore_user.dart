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

final fetchFirestoreUserProvider =
    FutureProvider<DocumentReference<firebaseUser.User>>((ref) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);
  final user = await ref.read(authenticationProvider).getCurrentUser();

  // Ensure that the current user is not null.
  if (user == null) {
    throw Future.error("Current user is null");
  }
  try {
    final collectionRef = db.collection(Collections.kUsers).withConverter(
          fromFirestore: firebaseUser.User.fromFirestore,
          toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
        );
    var querySnapshot =
        await collectionRef.where('uuid', isEqualTo: user.uid).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.reference;
    } else {
      throw Future.error("No user found");
    }
  } catch (e) {
    throw Future.error(e.toString());
  }
});

final userProvider = FutureProvider<firebaseUser.User?>((ref) async {
  final userReference = await ref.watch(fetchFirestoreUserProvider.future);
  final userSnapshot = await userReference.get();
  return userSnapshot.data();
});
