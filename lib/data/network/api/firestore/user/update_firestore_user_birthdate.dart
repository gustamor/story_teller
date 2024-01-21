import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/network/api/firestore/user/fetch_firestore_user.dart';


/// Updates the birth date field of the current authenticated user's document in Firestore.
///
/// Accepts a new birth date and updates the 'birthDate' field of the current user's document
/// in the Firestore database. It relies on [fetchCurrentUserProvider] to fetch a reference
/// to the current user's document and executes an update operation to modify the birth date.
///
/// Parameters:
///   - [ref]: Provides access to other providers and objects.
///   - [birthDate]: The new birth date to be set in the user's document.
///
/// This provider automatically disposes of itself after the operation is completed, ensuring
/// that it's only active when in use and preventing memory leaks. This behavior is enabled
/// by the `.autoDispose` modifier.
///
/// Throws:
///   - [Exception]: If an error occurs during the Firestore operation.
final updateBirthDateFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, DateTime>(
  (ref, birthDate) async {
    try {
      // Get a reference to the current user's document.
      final currentUserDocRef = await ref.watch(
        fetchCurrentUserProvider.future,
      );

      // Update the 'birthDate' field of the user's document.
      await currentUserDocRef.update({'birthDate': birthDate});
    } catch (e) {
      // Handle and propagate exceptions.
      throw Exception('Error updating user birth date: $e');
    }
  },
);
