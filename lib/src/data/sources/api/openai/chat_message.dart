// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/src/core/constants.dart';
import 'package:story_teller/src/data/sources/api/model/tale_data.dart';
import 'package:story_teller/src/data/sources/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/data/di/openai_provider.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';

/// Class responsible for managing chat interactions with the GPT model.
///
/// This class encapsulates the functionality required to communicate with a GPT model,
/// sending prompts and processing the generated responses.
class GptChatMessages {
  Ref ref;

  /// Constructor for [GptChatMessages].
  ///
  /// Requires a [Ref] object to access other providers, such as the OpenAI provider.
  GptChatMessages(this.ref);

  /// Logger for recording events and errors.
  final TellLogger log = LogImpl();

  /// Fetches a chat response from the GPT model based on the provided [prompt].
  ///
  /// This method sends a chat completion request to the GPT model with the user's [prompt]
  /// and processes the returned response. It ensures that valid content is received and logs
  /// any errors or anomalies encountered during the process.
  ///
  /// Returns the content of the GPT model's response as a string.
  /// Throws an exception if the response is invalid, empty, or null, or if an error occurs during the fetch process.
  Future<String> getGptChatResponse({required String prompt}) async {
    final client = ref.watch(openAiProvider);
    try {
      final res = await client.createChatCompletion(
        request: CreateChatCompletionRequest(
          model: const ChatCompletionModel.modelId('gpt-3.5-turbo'),
          messages: [
            const ChatCompletionMessage.system(content: kSimpleTaleAssistant),
            ChatCompletionMessage.user(
              content: ChatCompletionUserMessageContent.string(prompt),
            ),
          ],
          temperature: 0,
        ),
      );

      if (res.choices.isEmpty || res.choices.first.message.content == null) {
        log.e('Received invalid or null response from GPT model.');
        throw Exception('Failed to fetch GPT chat response.');
      }

      ChatCompletionMessage message = res.choices.first.message;
      log.d('GPT Chat Response: ${message.content}');
      return message.content.toString();
    } catch (e) {
      log.e('Error fetching GPT chat response: $e');
      throw Exception('Error fetching GPT chat response: $e');
    }
  }
}
