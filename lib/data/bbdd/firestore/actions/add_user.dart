// ignore_for_file: library_prefixes

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';

import 'package:story_teller/data/bbdd/firestore/models/user.dart' as fbUser;
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final addFirestoreUserProvider = FutureProvider<void>((ref) async {
  final db = ref.read(firebaseFirestoreProvider);
  final user = await ref.read(authenticationProvider).getCurrentUser();
  final newUser = fbUser.User(
    id: user!.uid,
    userName: user.displayName,
    email: user.email,
    photo: user.photoURL ?? "",
    tokens: 0,
  );

  try {
    final collectionRef = db.collection(Collections.kUsers).withConverter(
          fromFirestore: fbUser.User.fromFirestore,
          toFirestore: (fbUser.User user, _) => user.toFirestore(),
        );
    final docRef = collectionRef.doc(newUser.id);
    docRef.set(newUser, SetOptions(merge: true));
  } on FirebaseException catch (e) {
    print("Error adding user from Firebase: $e");
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
});
