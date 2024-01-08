// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/services/tale_data_repository_provider.dart';
import 'package:story_teller/src/data/sources/api/model/tale_data.dart';
import 'package:story_teller/src/data/sources/api/openai/chat_message.dart';
import 'package:story_teller/src/data/di/openai_provider.dart';
import 'package:story_teller/src/data/services/repositories/tale_data_repository.dart';

/// Provides a future of [TaleData?] based on a given prompt.
///
/// This provider is a family of futures, parameterized by a `String` prompt. It asynchronously
/// retrieves `TaleData` associated with the given prompt. The provider leverages a repository
/// to fetch the tale data, encapsulating the logic for data retrieval and error handling.
///
/// The [taleDataRepositoryProvider] is watched to obtain the relevant repository instance. If the
/// data fetching process encounters an error, an exception is thrown with the error details.
///
/// Usage of `FutureProvider.family` allows for efficient and context-sensitive data fetching, making
/// it easier to retrieve tale data based on varying prompts, which is essential in applications
/// with dynamic content based on user input or other changing parameters.
final taleDataProvider = FutureProvider.family<TaleData?, String>(
  (ref, prompt) async {
    try {
      final repo = await ref.watch(taleDataRepositoryProvider.future);
      final taleData = repo.getGPTTaleData(prompt: prompt);
      return taleData;
    } catch (e) {
      throw Exception(e);
    }
  },
);
