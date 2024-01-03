import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/bbdd/isar/actions/get_tale_provider.dart';
import 'package:story_teller/data/bbdd/isar/isar_provider.dart';
import 'package:story_teller/data/bbdd/isar/models/tale.dart';

//image = ["uuid", "imageurl"];
final upateTaleWithImageProvider =
    FutureProvider.family<void, List<String>>((ref, image) async {
  final isar = await ref.read(isarProvider.future);
  try {
    final tale = await ref.read(getTaleProvider(image[0]).future);

    tale!.imageUrl = image[1];
    await isar.writeTxn(() async {
      await isar.tales.put(tale);
    });
  } catch (e) {
    throw Exception(e);
  }
});
