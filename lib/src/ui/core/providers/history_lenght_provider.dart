import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/actions/get_tales.dart';


// Provider adicional para manejar la longitud
final talesLengthProvider = Provider<int>((ref) {
  final tales = ref.watch(getTalesProvider);
  return tales.asData?.value.length ?? 0;
});
