import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

/// Provides a stream of user-specific stories from Firestore.
///
/// Utilizes [firebaseFirestoreProvider] for database interactions and 
/// [authenticationProvider] for user authentication. This provider fetches
/// story documents from the Firestore database within the user's story
/// collection and uses a custom converter to map Firestore data to the
/// [Story] model. Each document in the Firestore's stories collection is
/// transformed into a [Story] instance.
///
/// An [Exception] is thrown for any errors during Firestore operations.
/// This includes [FirebaseException] for Firestore-specific issues (e.g., 
/// network problems, document not found) and generic exceptions for other
/// unforeseen errors.
///
/// Returns a stream of [List<Story>] representing the stories associated
/// with the current user.
final getTalesProvider = StreamProvider<List<Story>>((ref) async* {
  // Access the Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve the ID of the currently authenticated user.
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    // Stream Firestore snapshots, converting each document to a [Story].
    yield* db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  } on FirebaseException catch (e) {
    // Handle Firebase-specific exceptions.
    throw Exception('FirebaseException: $e');
  } catch (e) {
    // Handle other exceptions.
    throw Exception('General Exception: $e');
  }
});
