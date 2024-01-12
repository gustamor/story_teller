// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/// Provider for fetching a specific story from Firestore based on its ID.
///
/// Retrieves a story document from the Firestore database within the user's
/// story collection. This function is a FutureProvider family, allowing it
/// to accept an ID parameter for identifying the specific story to be fetched.
///
/// Utilizes [firebaseFirestoreProvider] for database access and
/// [authenticationProvider] for obtaining the current authenticated user's ID.
/// The story is retrieved using a custom converter for the [Story] model.
///
/// Throws an [Exception] if there's an error during the Firestore operation.
///
/// Parameters:
///   [ref] - A reference to other objects and providers.
///   [id] - The unique ID of the story to be fetched.
///
/// Returns the [Story] object corresponding to the provided ID.
final getFirebaseTaleProvider = FutureProvider.family<Story, String>((ref, id) async {
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
        .doc(id)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        );

    // Fetch the document snapshot.
    final docSnap = await docRef.get();

    // Extract and return the story data.
    final story = docSnap.data();
    return story!;
  } on FirebaseException catch (e) {
    // Handle and throw Firebase specific exceptions.
    if (kDebugMode) {
      print("Error fetching story from Firebase: $e");
    }
    throw Exception(e);
  } catch (e) {
    // Handle any other exceptions.
    throw Exception(e);
  }
});
