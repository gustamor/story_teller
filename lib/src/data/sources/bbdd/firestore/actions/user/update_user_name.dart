import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart'
    as firebaseUser;

final updateNameFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, String>((ref, userName) async {
  final db = ref.read(firebaseFirestoreProvider);
  final user = await ref.read(authenticationProvider).getCurrentUser();

  try {
    final collectionRef = db.collection(Collections.kUsers).withConverter(
          fromFirestore: firebaseUser.User.fromFirestore,
          toFirestore: (firebaseUser.User user, _) => user.toFirestore(),
        );

    var querySnapshot =
        await collectionRef.where('id', isEqualTo: user!.uid).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDocRef = querySnapshot.docs.first.reference;
      await userDocRef.update({'name': userName});
    } else {
      throw Exception("No user found");
    }
  } catch (e) {
    throw Exception(e);
  }
});
