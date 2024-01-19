import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/repositories/tale_data_repository.dart';

/// Provides an instance of [TaleDataRepository].
///
/// Responsible for creating and managing [TaleDataRepository], which serves as an interface
/// for data operations related to tale data. This provider ensures that any data operation
/// is executed through a consistent and centralized repository, promoting clean architecture
/// and maintainable code.
final taleDataRepositoryProvider = FutureProvider<TaleDataRepository>((ref) async {
  return TaleDataRepository(ref: ref);
});
