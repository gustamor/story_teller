// ignore_for_file: library_prefixes

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart'
    as firebaseUser;
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/// Provider for adding a new user to Firestore.
///
/// Asynchronously fetches the current user's details and adds them to the
/// Firestore database under the user's collection. The operation merges new
/// data with existing data, ensuring no loss of information.
///
/// Uses [firebaseFirestoreProvider] to access the Firestore database and
/// [authenticationProvider] to obtain the current authenticated user's
/// information. Constructs a [fbUser.User] object with the user's details.
///
/// Throws an [Exception] if there's an error during the Firestore operation.
final addFirestoreUserProvider = FutureProvider<void>((ref) async {
  // Access Firestore database reference.
  final db = ref.read(firebaseFirestoreProvider);

  // Retrieve current authenticated user.
  final user = await ref.read(authenticationProvider).getCurrentUser();

  try {
    //Check if user exists
    final currentUser = ref.watch(userProvider);
    if (currentUser.value!.email == null) {
      // Construct a new user object with relevant details.
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

      // Define the Firestore collection with a custom converter for the User object.
      final collectionRef = db.collection(Collections.kUsers).withConverter(
            fromFirestore: firebaseUser.User.fromFirestore,
            toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
          );

      // Reference to the user's document in the collection.
      final docRef = collectionRef.doc(newUser.id);

      // Set the user data in Firestore, merging with existing data.
      docRef.set(newUser, SetOptions(merge: true));
    } else {
      print("");
    }
  } on FirebaseException catch (e) {
    // Handle and throw Firebase specific exceptions.
    throw Exception(e);
  } catch (e) {
    // Handle any other exceptions.
    throw Exception(e);
  }
});
