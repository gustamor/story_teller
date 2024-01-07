// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/api/openai/chat_message.dart';
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/data/services/repositories/tale_data_repository.dart';

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
