import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/sources/api/openai/dalle_image_request.dart';

/// Provides an instance of [DalleImageRequest].
///
/// Initializes [DalleImageRequest] to generate and fetch URLs for images created by DALL-E,
/// an AI model renowned for creating images from textual descriptions. Utilizes the `ref` parameter
/// for accessing other providers or resources within the Riverpod framework, thereby seamlessly
/// integrating DALL-E's image generation capabilities into the application.
final dalleProvider = Provider<DalleImageRequest>((ref) {
  return DalleImageRequest(ref);
});
