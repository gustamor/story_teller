// ignore_for_file: unused_import

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/api/openai/chat_message.dart';
import 'package:story_teller/di/openai_providers.dart';

class ChatService {
  Ref ref;
  ChatService(
    this.ref,
  );

  Future<TaleData> generateTale({required String prompt}) async {
    final chatMessage = ref.watch(chatMessageProvider);

    try {
      final taleData =
          await chatMessage.generateStory(prompt: prompt);
      return taleData;
    } catch (e) {
      throw Exception(e);
    }
  }
}
