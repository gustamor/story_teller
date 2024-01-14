import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';

final updateSurnamesFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, surnames) async {
    try {
      final currentUserDocRef = ref.watch(
        fetchCurrentUserProvider.future,
      );
      currentUserDocRef.then(
        (value) => value.update(
          {'surnames': surnames},
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  },
);
