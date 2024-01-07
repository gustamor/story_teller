import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

/// Provider for uploading or updating a story in Firestore.
///
/// Accepts [TaleData], which contains the story information, and uploads or
/// updates it in the Firestore database under the user's story collection.
/// Utilizes [firebaseFirestoreProvider] for database access and
/// [authenticationProvider] to obtain the current authenticated user's ID.
///
/// This provider handles the conversion of [TaleData] to a [Story] object and
/// sets the story's date and user ID before uploading. The operation merges
/// new data with existing data, ensuring no loss of information.
///
/// Parameters:
///   [ref] - A reference to other objects and providers.
///   [taleData] - The data of the tale to be uploaded or updated.
///
/// Throws an [Exception] if there's an error during the Firestore operation.
final uploadTaleProvider =
    FutureProvider.family<void, TaleData>((ref, taleData) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user's ID.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    if (currentUser != null) {
      // Define the Firestore collection with a custom converter for the Story object.
      final collectionRef = db
          .collection(Collections.kUsers)
          .doc(currentUser.uid)
          .collection(Collections.kStories)
          .withConverter(
            fromFirestore: Story.fromFirestore,
            toFirestore: (Story story, _) => story.toFirestore(),
          );

      // Reference to the specific story document in the collection.
      final docRef = collectionRef.doc(taleData.id);

      // Convert TaleData to a Story object, updating date and user ID.
      Story story = taleData.toStory(currentUser.uid);

      // Set the story data in Firestore, merging with existing data.
      await docRef.set(story, SetOptions(merge: true));
    } else {
      // Throw an exception if the user is not found.
      throw Exception("User not found");
    }
  } on FirebaseException catch (e) {
    // Handle and throw Firebase specific exceptions.
    throw Exception("FirebaseException: $e");
  } catch (e) {
    // Handle any other exceptions.
    throw Exception("General Exception: $e");
  }
});
