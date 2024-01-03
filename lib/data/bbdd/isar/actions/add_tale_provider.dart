// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/bbdd/isar/isar_provider.dart';
import 'package:story_teller/data/bbdd/isar/models/tale.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final addTaleProvider =
    FutureProvider.family<void, TaleData>((ref, taleData) async {
  final isar = await ref.read(isarProvider.future);
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  final tale = Tale()
    ..idUser = currentUser!.uid
    ..uuid = taleData.id
    ..title = taleData.title
    ..story = taleData.story
    ..date = DateTime.now()
    ..prompt = taleData.prompt;

  try {
    await isar.writeTxn(() async {
      await isar.tales.put(tale);
    });
  } catch (e) {
    throw Exception(e);
  }
});
