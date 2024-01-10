// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:story_teller/src/data/sources/api/model/tale_data.dart';
import 'package:story_teller/src/data/di/gpt_chat_messages_provider.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';


class TaleDataRepository {
  Ref ref;
  TaleDataRepository({
    required this.ref,
  });

  /// Implements a [TellLogger] instance
  final TellLogger log = LogImpl();

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

  Future<TaleData?> getMistralTaleData({required String prompt}) async {
   throw UnimplementedError();
  }
}
