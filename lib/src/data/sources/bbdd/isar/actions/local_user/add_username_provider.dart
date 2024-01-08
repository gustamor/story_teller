// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/local_user/add_auth_id_to_user_provider.dart';
import 'package:story_teller/src/data/di/isar_provider.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/user.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

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
