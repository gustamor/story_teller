// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/di/tale_data_repository_provider.dart';
import 'package:story_teller/data/sources/api/model/tale_data.dart';
import 'package:story_teller/data/sources/api/openai/chat_message.dart';
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/data/services/repositories/tale_data_repository.dart';

/// Provides a future of [TaleData?] based on a given prompt.
///
/// This provider, as a family of futures parameterized by a `String` prompt, asynchronously retrieves
/// [TaleData] associated with the given prompt. It utilizes [taleDataRepositoryProvider] to fetch the
/// tale data, encapsulating the logic for data retrieval and error handling.
///
/// Leveraging `FutureProvider.family` enables efficient and context-sensitive data fetching, crucial for
/// applications requiring dynamic content based on user input or other changing parameters. If the data
/// fetching process encounters an error, an exception is thrown, detailing the error encountered.
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
