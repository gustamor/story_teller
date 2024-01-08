// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/user.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/user.dart';
import 'package:story_teller/src/data/di/isar_provider.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

/* final getCurrentUserProvider = FutureProvider<LocalUser?>((ref) async {
  
  final currentUserId = ref.read(authenticationProvider).getCurrentUser();
  final isar = ref.read(isarProvider.future);
  /* final user =
      await isar. .filter().authIdEqualTo(currentUserId).findFirst();
 */
  return user;
});
 */