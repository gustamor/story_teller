import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/sources/api/model/tale_data.dart';
import 'package:story_teller/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

/// Uploads or updates a story in Firestore.
///
/// Accepts [TaleData] containing the story's details and performs an upload or
/// update operation in the Firestore database within the authenticated user's
/// story collection. It leverages [firebaseFirestoreProvider] for database
/// interactions and [authenticationProvider] to fetch the current authenticated
/// user's ID.
///
/// This provider converts [TaleData] into a [Story] object, ensuring the story's
/// date and user ID are set before uploading. It performs a merge operation to
/// integrate new data with any existing data, preserving existing fields that
/// are not being updated.
///
/// Parameters:
///   - [ref]: Provides access to other providers and objects.
///   - [taleData]: The [TaleData] object containing the story's information to
///     be uploaded or updated.
///
/// Throws:
///   - [Exception]: If the user is not authenticated or any other error occurs
///     during the Firestore operation.
///   - [FirebaseException]: Specifically for Firestore-related issues during
///     the operation.
final uploadTaleProvider =
    FutureProvider.family<void, TaleData>((ref, taleData) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user's ID.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    if (currentUser != null) {
      // Firestore collection with a custom converter for the Story object.
      final collectionRef = db
          .collection(Collections.kUsers)
          .doc(currentUser.uid)
          .collection(Collections.kStories)
          .withConverter(
            fromFirestore: Story.fromFirestore,
            toFirestore: (Story story, _) => story.toFirestore(),
          );

      // Reference to the specific story document.
      final docRef = collectionRef.doc(taleData.id);

      // Convert TaleData to a Story object, including date and user ID.
      Story story = taleData.toStory(currentUser.uid);

      // Upload or merge the story data in Firestore.
      await docRef.set(story, SetOptions(merge: true));
    } else {
      // Handle the case where the user is not authenticated.
      throw Exception("User not authenticated");
    }
  } on FirebaseException catch (e) {
    // Handle Firestore-specific exceptions.
    throw Exception("FirebaseException: $e");
  } catch (e) {
    // Handle any other exceptions.
    throw Exception("General Exception: $e");
  }
});
