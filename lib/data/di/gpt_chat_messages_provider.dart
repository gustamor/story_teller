
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/network/api/openai/chat_message.dart';


/// Provides an instance of [GptChatMessages].
///
/// Responsible for creating and managing [GptChatMessages]. It utilizes the `ref` parameter 
/// to allow [GptChatMessages] to access other providers or resources within the Riverpod ecosystem.
final chatGptMessageProvider = Provider<GptChatMessages>((ref) {
  return GptChatMessages(ref);
});
