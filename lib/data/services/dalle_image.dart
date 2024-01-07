import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/api/openai/dalle_image.dart';

/// Provides an instance of [DalleImage].
///
/// This provider creates an instance of `DalleImage`, which is specialized in generating
/// and retrieving URL links for images created by DALL-E, an AI model known for generating
/// images from textual descriptions. The instance uses the `ref` parameter to access other
/// providers or resources within the Riverpod framework, facilitating the integration of
/// DALL-E's capabilities into the broader application.
final dalleProvider = Provider<DalleImage>((ref) {
  return DalleImage(ref);
});
