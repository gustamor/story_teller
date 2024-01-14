// ignore_for_file: unused_import

import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/di/firebase_providers.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart'
    as firebaseUser;

final updateNameFirestoreUserProvider =
    FutureProvider.autoDispose.family<void, String>(
  (ref, userName) async {
    try {
      final currentUserDocRef = ref.watch(
        fetchCurrentUserProvider.future,
      );
      currentUserDocRef.then(
        (value) => value.update(
          {'name': userName},
        ),
      );
    } catch (e) {
      throw Exception(e);
    }
  },
);


