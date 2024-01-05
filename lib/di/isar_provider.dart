import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:story_teller/data/bbdd/isar/models/tale.dart';
import 'package:story_teller/data/bbdd/isar/models/user.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [LocalUserSchema, TaleSchema],
    directory: dir.path,
    inspector: true,
  );
  
  return isar;
});
