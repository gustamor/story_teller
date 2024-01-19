import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';


/// Updates the image URL of a specific story in Firestore.
///
/// Requires a list containing the story's UUID and the new image URL. This
/// provider updates the corresponding story document's image URL in Firestore,
/// leveraging [firebaseFirestoreProvider] for database interactions and
/// [authenticationProvider] for authenticating the current user. The operation
/// is performed atomically within a Firestore transaction to ensure data
/// consistency.
///
/// Parameters:
///   - [ref]: Provides access to other providers and objects.
///   - [image]: A list where the first element is the story's UUID and the
///              second element is the new image URL.
///
/// Throws:
///   - [FirebaseException]: If any Firestore-specific issues occur during the
///     transaction or update process.
///   - [Exception]: For any other errors during the Firestore operation.
final updateStoryWithImageUrl =
    FutureProvider.family<void, List<String>>((ref, image) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user's ID.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    // Reference to the specific story document in Firestore.
    final docRef = db
        .collection(
          Collections.kUsers,
        )
        .doc(
          currentUser!.uid,
        )
        .collection(
          Collections.kStories,
        )
        .doc(
          image[0],
        );

    // Run a transaction to update the story's image URL.
    await db.runTransaction((transaction) async {
      transaction.update(
        docRef,
        {
          "imageUrl": image[1],
        },
      );
    });
  } on FirebaseException catch (e) {
    // Handle Firestore-specific exceptions.
    throw Exception('FirebaseException: $e');
  } catch (e) {
    // Handle any other exceptions.
    throw Exception('General Exception: $e');
  }
});
