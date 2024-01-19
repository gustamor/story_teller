// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/sources/api/openai/chat_message.dart';
import 'package:story_teller/data/sources/api/openai/dalle_image_request.dart';
import 'package:story_teller/data/di/taledata_provider.dart';

/// Provides an initialized [OpenAIClient].
///
/// Initializes [OpenAIClient] using the OpenAI API key and organization details fetched from
/// environment variables. It's crucial for leveraging OpenAI's services, including language models
/// and other AI functionalities. 
///
/// Throws an [Exception] if the environment variables for the OpenAI API key or the organization
/// details are not properly set, ensuring that the application only runs with the necessary
/// OpenAI service configurations.
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

