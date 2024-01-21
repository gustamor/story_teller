// ignore_for_file: library_prefixes

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/data/network/api/firestore/user/fetch_firestore_user.dart';
import 'package:story_teller/data/network/api/firestore/model/user.dart'
    as firebaseUser;
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

/// Adds a new user to Firestore or merges with existing user data.
///
/// Asynchronously registers the current authenticated user's details in the
/// Firestore database within the users collection. This provider ensures that
/// new data is intelligently merged with any pre-existing user data, preventing
/// unintended data loss.
///
/// It relies on [firebaseFirestoreProvider] for Firestore database interactions
/// and [authenticationProvider] for fetching the current authenticated user's
/// details. A new [fbUser.User] object is created, populated with user details
/// from the authentication provider.
///
/// Throws:
///   - [FirebaseException]: Specifically for Firestore-related issues during
///     user data operations.
///   - [Exception]: For any other errors that occur during the process.
final addFirestoreUserProvider = FutureProvider<void>(
  (ref) async {
    // Access Firestore database reference.
    final db = ref.read(firebaseFirestoreProvider);

    // Retrieve current authenticated user.
    final user = await ref.read(authenticationProvider).getCurrentUser();

    try {
      // Check if user exists by watching the userProvider.
      final currentUser = ref.watch(userProvider);
      if (currentUser.value!.email == null) {
        // Create a new user object with obtained details.
        final newUser = firebaseUser.User(
          id: user!.uid,
          userName: user.displayName ?? "",
          email: user.email,
          photo: user.photoURL ?? "",
          tokens: 0,
          name: "",
          surnames: "",
          birthDate: null,
          isPremium: null,
        );

        // Firestore collection with a custom converter for the User object.
        final collectionRef = db.collection(Collections.kUsers).withConverter(
              fromFirestore: firebaseUser.User.fromFirestore,
              toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
            );

        // Reference to the user's document.
        final docRef = collectionRef.doc(newUser.id);

        // Upload or merge the user data in Firestore.
        docRef.set(newUser, SetOptions(merge: true));
      } else {
        // Handle the case where the user already exists.
        // [Optionally, add any code needed or leave it empty if no action is required]
      }
    } on FirebaseException catch (e) {
      // Handle Firestore-specific exceptions.
      throw Exception('FirebaseException: $e');
    } catch (e) {
      // Handle any other exceptions.
      throw Exception('General Exception: $e');
    }
  },
);
