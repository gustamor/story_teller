import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';

final openAiProvider = Provider<OpenAIClient>((ref) {
  final openaiApiKey = Platform.environment['OPENAI_API_KEY'];
  final openaiOrganization =  Platform.environment['OPENAI_ORGANIZATION'];
  return OpenAIClient(apiKey: openaiApiKey,organization: openaiOrganization);
});
