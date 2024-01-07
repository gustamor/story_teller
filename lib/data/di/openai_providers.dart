// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/api/openai/chat_message.dart';
import 'package:story_teller/data/api/openai/dalle_image.dart';
import 'package:story_teller/data/services/taledata_provider.dart';

final openAiProvider = Provider<OpenAIClient>((ref) {
  final openaiApiKey = dotenv.env['OPENAI_API_KEY'];
  final openaiOrganization = dotenv.env['OPENAI_ORGANIZATION'];
  return OpenAIClient(apiKey: openaiApiKey, organization: openaiOrganization);
});

final dalleProvider = Provider<DalleImage>((ref) {
  return DalleImage(ref);
});

final chatGptMessageProvider = Provider<GptChatMessages>((ref) {
  return GptChatMessages(ref);
});
/* final chatServiceProvider = Provider<TaleDataService>((ref) {
  return TaleDataService(ref);
}); */
