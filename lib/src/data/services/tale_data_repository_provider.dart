import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/services/repositories/tale_data_repository.dart';

final taleDataRepositoryProvider = FutureProvider<TaleDataRepository>((ref) async {
  return TaleDataRepository(ref: ref) ;
});
