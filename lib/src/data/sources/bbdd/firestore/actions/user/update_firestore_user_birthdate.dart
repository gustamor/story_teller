import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';

final updateBirthDateFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, DateTime>(
  (ref, birthDate) async {
    try {
      final currentUserDocRef = ref.watch(
        fetchCurrentUserProvider.future,
      );
      currentUserDocRef.then(
        (value) => value.update(
          {'birthDate': birthDate},
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  },
);
