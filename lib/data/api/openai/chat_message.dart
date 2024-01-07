// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/api/model/tale_data.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/data/di/openai_providers.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

/// Implements a [TellLogger] instance
final TellLogger log = LogImpl();

class GptChatMessages {
  Ref ref;
  GptChatMessages(
    this.ref,
  );

  Future<String> getGptChatResponse({required String prompt}) async {
    final client = ref.watch(openAiProvider);
    try {
      final res = await client.createChatCompletion(
        request: CreateChatCompletionRequest(
          model: const ChatCompletionModel.modelId(
            'gpt-3.5-turbo',
          ),
          messages: [
            const ChatCompletionMessage.system(
              content: kSimpleTaleAssistant,
            ),
            ChatCompletionMessage.user(
              content: ChatCompletionUserMessageContent.string(
                prompt,
              ),
            ),
          ],
          temperature: 0,
        ),
      );
      ChatCompletionMessage message = res.choices.first.message;
      log.d(message.content);
      return message.content.toString();
    } catch (e) {
      throw Exception(e);
    }
  }
}
