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
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

/// Represents the management of GPT chat messages.
///
/// This class facilitates the interaction with a GPT AI model by sending
/// prompts and receiving responses. It uses a [TellLogger] instance for
/// logging purposes.
class GptChatMessages {
  /// Reference to other objects managed by the provider.
  Ref ref;

  /// Constructor to create [GptChatMessages] with a given [ref].
  GptChatMessages(
    this.ref,
  );

  /// Logger instance for debugging and logging.
  ///
  /// Implements a [TellLogger] for capturing logs during the execution of chat
  /// message operations.
  final TellLogger log = LogImpl();

  /// Asynchronously fetches a response from the GPT chat model.
  ///
  /// Sends a [prompt] to the GPT model and returns the AI's response. Utilizes
  /// the OpenAI API for generating chat completions. In case of an error during
  /// the API call, an exception is thrown.
  ///
  /// Throws [Exception] if there is an error in fetching the response.
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
