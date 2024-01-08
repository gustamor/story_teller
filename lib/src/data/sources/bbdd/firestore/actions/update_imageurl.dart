
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/// Provider for updating a story's image URL in Firestore.
///
/// Accepts a list containing the story's UUID and the new image URL, then
/// updates the corresponding story document in Firestore. It uses
/// [firebaseFirestoreProvider] for database access and [authenticationProvider]
/// to obtain the current authenticated user's ID.
///
/// This provider handles the Firestore update within a transaction to ensure
/// atomicity. If an error occurs during the transaction or update, an
/// exception is thrown.
///
/// Parameters:
///   [ref] - A reference to other objects and providers.
///   [image] - A list where the first element is the story's UUID and the
///             second element is the new image URL.
///
/// Throws an [Exception] if there's an error during the Firestore operation.
final upateStoryWithImageUrl =
    FutureProvider.family<void, List<String>>((ref, image) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user's ID.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    // Define reference to the specific story document in Firestore.
    final docRef = db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .doc(image[0]);

    // Run a transaction to update the story's image URL.
    db.runTransaction((transaction) async {
      // Update the document within the transaction.
      transaction.update(docRef, {"imageUrl": image[1]});
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"),
    );
  } on FirebaseException catch (e) {
    // Handle and throw Firebase specific exceptions.
    print("Error updating story from Firebase: $e");
    throw Exception(e);
  } catch (e) {
    // Handle any other exceptions.
    throw Exception(e);
  }
});
