import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';

/// Updates the surnames field of the current authenticated user's document in Firestore.
///
/// Accepts a string representing the new surnames and updates the 'surnames' field
/// of the current user's document in the Firestore database. It leverages [fetchCurrentUserProvider]
/// to obtain a reference to the current user's document and conducts an update operation.
///
/// Parameters:
///   - [ref]: Provides access to other providers and objects.
///   - [surnames]: The new surnames to be updated in the user's document.
///
/// This provider is automatically disposed after the operation is complete, ensuring
/// efficient resource usage and preventing memory leaks. This is facilitated by the
/// `.autoDispose` modifier.
///
/// Throws:
///   - [Exception]: If an error occurs during the Firestore operation.
final updateSurnamesFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, surnames) async {
    try {
      // Retrieve a reference to the current user's document.
      final currentUserDocRef = await ref.watch(
        fetchCurrentUserProvider.future,
      );

      // Update the 'surnames' field of the user's document.
      await currentUserDocRef.update({'surnames': surnames});
    } catch (e) {
      // Handle and propagate exceptions.
      throw Exception('Error updating user surnames: $e');
    }
  },
);
