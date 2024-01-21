import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/network/api/firestore/tale/get_tales.dart';


// Provider adicional para manejar la longitud
final talesLengthProvider = Provider<int>((ref) {
  final tales = ref.watch(getTalesProvider);
  return tales.asData?.value.length ?? 0;
});
