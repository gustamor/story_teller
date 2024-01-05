import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/di/isar_provider.dart';
import 'package:story_teller/data/bbdd/isar/models/user.dart';

final addUserNameProvider =
    FutureProvider.family.autoDispose<void, String>((ref, userName) async {
  try {
    final isar = await ref.read(isarProvider.future);

    final user = LocalUser()..name = userName;
    await isar.writeTxn(() async {
      await isar.localUsers.put(user);
    });
  } catch (e) {
    throw Exception(e);
  }
});
final addEmailNameProvider =
    FutureProvider.family.autoDispose<void, String>((ref, userName) async {
  try {
    final isar = await ref.read(isarProvider.future);

    final user = LocalUser()..name = userName;
    await isar.writeTxn(() async {
      await isar.localUsers.put(user);
    });
  } catch (e) {
    throw Exception(e);
  }
});
