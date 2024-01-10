
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/api/openai/chat_message.dart';

/// Provides an instance of [GptChatMessages].
///
/// This provider is responsible for creating and managing an instance of `GptChatMessages`.
/// It facilitates handling and storing messages exchanged with a GPT-based chat interface.
/// The `ref` argument is passed to the `GptChatMessages` constructor, allowing it to access 
/// other providers or resources managed by the Riverpod library.
final chatGptMessageProvider = Provider<GptChatMessages>((ref) {
  return GptChatMessages(ref);
});
