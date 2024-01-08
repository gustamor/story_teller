import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:story_teller/src/data/di/isar_provider.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/models/tale.dart';

final getTaleProvider =
    FutureProvider.family<Tale?, String>((ref, uuid) async {
  final isar = await ref.read(isarProvider.future);
  final tale = await isar.tales.filter().uuidEqualTo(uuid).findFirst();
  return tale;
});
