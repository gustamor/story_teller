// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/core/params.dart';
import 'package:story_teller/data/sources/api/openai/chat_message.dart';
import 'package:story_teller/data/sources/api/openai/dalle_image_request.dart';
import 'package:story_teller/data/di/taledata_provider.dart';

/// Provides an initialized [OpenAIClient].
///
/// Initializes [OpenAIClient] using the OpenAI API key and organization details fetched from
/// environment variables. This is essential for accessing OpenAI's services, including language models
/// and other AI functionalities.
///
/// Throws an [Exception] if the environment variables for the OpenAI API key or organization
/// details are not set, ensuring the application runs only with valid OpenAI service configurations.
final openAiProvider = Provider<OpenAIClient>(
  (
    ref,
  ) {
    try {
      final openaiApiKey = Params.oakey;
      final openaiOrganization = Params.oaorg;

      // Validate that the OpenAI API key and organization details are not empty
      if (openaiApiKey.isEmpty || openaiOrganization.isEmpty) {
        throw Exception(
          'OpenAI API key and/or organization are not set in environment variables.',
        );
      }

      // Return an instance of OpenAIClient with the fetched API key and organization details
      return OpenAIClient(
        apiKey: openaiApiKey,
        organization: openaiOrganization,
      );
    } catch (e) {
      // Rethrow the exception with a clear message indicating missing environment variables
      throw Exception(
        'Failed to initialize OpenAIClient: $e}',
      );
    }
  },
);
