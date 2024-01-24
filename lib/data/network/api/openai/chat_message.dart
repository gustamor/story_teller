// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/core/params.dart';
import 'package:story_teller/data/network/api/openai/model/tale_data.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/data/di/openai_provider.dart';
import 'package:story_teller/domain/abstract/services/abstract_tell_logger.dart';
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

  /// Fetches a chat response from the GPT model based on the provided [prompt].
  ///
  /// This method sends a chat completion request to the GPT model with the user's [prompt]
  /// and processes the returned response. It ensures that valid content is received and logs
  /// any errors or anomalies encountered during the process.
  ///
  /// Parameters:
  ///   - [prompt]: The input prompt string sent to the GPT model.
  ///
  /// Returns:
  ///   The content of the GPT model's response as a string.
  ///   Throws an exception if the response is invalid, empty, or null, or if an error occurs during the fetch process.
  Future<String> getGptChatResponse({required String prompt}) async {
    final client = ref.watch(openAiProvider);
    try {
      final res = await client.createChatCompletion(
        request: CreateChatCompletionRequest(
          model:  ChatCompletionModel.modelId(Params.gptModel),
          messages: [
             ChatCompletionMessage.system(content: Params.gptPrompt),
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
