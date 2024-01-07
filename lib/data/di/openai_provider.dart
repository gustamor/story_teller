// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/api/openai/chat_message.dart';
import 'package:story_teller/data/api/openai/dalle_image.dart';
import 'package:story_teller/data/services/taledata_provider.dart';

/// Provides an instance of [OpenAIClient].
///
/// This provider initializes an OpenAIClient using API key and organization details
/// obtained from environment variables. It's essential for interacting with OpenAI's services
/// such as language models or other AI functionalities.
///
/// Throws an exception if the required environment variables for the OpenAI API key or
/// organization are not set. This ensures that the application does not proceed without the
/// necessary configuration for OpenAI services.
final openAiProvider = Provider<OpenAIClient>((
  ref,
) {
  final openaiApiKey = dotenv.env['OPENAI_API_KEY'];
  final openaiOrganization = dotenv.env['OPENAI_ORGANIZATION'];

  if (openaiApiKey == null || openaiOrganization == null) {
    throw Exception(
      'OpenAI API key and/or organization are not set in environment variables.',
    );
  }

  return OpenAIClient(
    apiKey: openaiApiKey,
    organization: openaiOrganization,
  );
});

