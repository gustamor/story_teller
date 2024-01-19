// ignore_for_file: unused_import

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';
import 'package:story_teller/data/sources/bbdd/firestore/models/user.dart'
    as firebaseUser;

/// Updates the name field of the current authenticated user's document in Firestore.
///
/// Accepts a new user name and updates the 'name' field of the current user's document
/// in the Firestore database. It uses [fetchCurrentUserProvider] to obtain a reference
/// to the current user's document and performs an update operation.
///
/// Parameters:
///   - [ref]: Provides access to other providers and objects.
///   - [userName]: The new name to be updated in the user's document.
///
/// This provider automatically disposes of itself after the operation is completed.
/// It uses the `.autoDispose` modifier to achieve this behavior, ensuring no memory
/// leaks and that the provider is only active when in use.
///
/// Throws:
///   - [Exception]: If an error occurs during the Firestore operation.
final updateNameFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, userName) async {
    try {
      // Get a reference to the current user's document.
      final currentUserDocRef = await ref.watch(
        fetchCurrentUserProvider.future,
      );

      // Update the 'name' field of the user's document.
      await currentUserDocRef.update({'name': userName});
    } catch (e) {
      // Handle and propagate exceptions.
      throw Exception('Error updating user name: $e');
    }
  },
);
