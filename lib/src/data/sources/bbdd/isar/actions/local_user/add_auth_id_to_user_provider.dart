import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/user.dart';
import 'package:story_teller/src/data/di/isar_provider.dart';

final addAuthIdProvider =
    FutureProvider.family.autoDispose<void, String>((ref, authId) async {
  try {
    final isar = await ref.read(isarProvider.future);

    final user = LocalUser()..authId = authId;
    await isar.writeTxn(() async {
      await isar.localUsers.put(user);
    });
  } catch (e) {
    throw Exception(e);
  }
});