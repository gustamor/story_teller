// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_import
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/constants.dart';
import 'package:story_teller/core/initializers.dart';

import 'package:story_teller/data/network/api/openai/model/tale_data.dart';
import 'package:story_teller/data/di/gpt_chat_messages_provider.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/abstract/services/abstract_tell_logger.dart';

/// Repository for managing tale data operations.
///
/// This class handles the communication with GPT-based chat services to fetch and process
/// tale data. It utilizes the [chatGptMessageProvider] to make requests and receive responses.
class TaleDataRepository {
  Ref ref;

  /// Constructor for [TaleDataRepository].
  ///
  /// Initializes the repository with a [Ref] object to access other providers.
  TaleDataRepository({
    required this.ref,
  });


  /// Fetches tale data from a GPT-based chat service using the given [prompt].
  ///
  /// Sends a request to the chat service with the [prompt] and processes the received response.
  /// The response is converted into a [TaleData] object. Logging is performed for the fetched data.
  ///
  /// Parameters:
  ///   - [prompt]: The prompt string used to fetch the tale data.
  ///
  /// Returns:
  ///   A [TaleData] object representing the fetched tale data, or null if the data couldn't be fetched or processed.
  Future<TaleData?> getGPTTaleData({required String prompt}) async {
    final chatMessage = ref.watch(chatGptMessageProvider);
    final response = await chatMessage.getGptChatResponse(prompt: prompt);
    final taleData = TaleData.fromMap(
      json.decode(response),
    );
    log.d(
      taleData,
    );
    return taleData;
  }
}
