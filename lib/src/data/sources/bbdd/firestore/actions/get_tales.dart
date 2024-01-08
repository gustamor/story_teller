import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/// Provider for fetching a list of stories from Firestore.
///
/// Retrieves all story documents from the Firestore database within the user's
/// story collection. It uses [firebaseFirestoreProvider] for database access
/// and [authenticationProvider] to identify the current authenticated user.
///
/// This provider uses a custom converter to map between Firestore data and
/// the [Story] model. Each document in the stories collection is transformed
/// into a [Story] object.
///
/// Throws an [Exception] if there's an error during the Firestore operation.
///
/// Returns a list of [Story] objects representing the user's stories.
final getTalesProvider = FutureProvider<List<Story>>((ref) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user's ID.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  // Initialize an empty list to store the fetched stories.
  List<Story> stories = [];

  try {
    // Query the stories collection and apply the custom converter.
    var storiesCollection = await db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        )
        .get(); // Execute the query and receive the result.

    // Iterate through each document snapshot and add to the stories list.
    for (var storySnapshot in storiesCollection.docs) {
      final story = storySnapshot.data();
      stories.add(story);
    }
    return stories;
  } on FirebaseException catch (e) {
    // Handle and throw Firebase specific exceptions.
    throw Exception(e);
  } catch (e) {
    // Handle any other exceptions.
    throw Exception(e);
  }
});
