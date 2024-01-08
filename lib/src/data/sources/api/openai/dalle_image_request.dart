import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/src/data/di/openai_provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Class responsible for requesting images from the DALL-E model.
///
/// This class uses the OpenAI service provider to generate images based on textual prompts.
/// It facilitates the creation of image links by interacting with the OpenAI API.
class DalleImageRequest {
  Ref ref;

  /// Constructor for [DalleImageRequest].
  ///
  /// Requires a [Ref] object to watch and use the OpenAI service provider.
  DalleImageRequest(this.ref);

  /// Asynchronously generates an image link based on the provided parameters.
  ///
  /// This method sends a request to the OpenAI service to create an image using DALL-E
  /// based on the specified [prompt], [model], [size], and [style].
  ///
  /// The [prompt] is a required textual description of the image to be generated.
  /// The [model] specifies the DALL-E model version to use; defaults to `ImageModels.dallE2`.
  /// The [size] and [style] parameters are optional and control the size and style of the generated image.
  ///
  /// Returns the URL of the generated image, or `null` in case of an error or failure in image generation.
  Future<String?> generateImageLink({
      required String prompt,
      required ImageModels? model,
      ImageSize? size,
      ImageStyle? style}) async {
    final client = ref.watch(openAiProvider);
    try {
      final ImagesResponse res = await client.createImage(
        request: CreateImageRequest(
          model: CreateImageRequestModel.model(model ?? ImageModels.dallE2),
          prompt: prompt,
          quality: ImageQuality.standard,
          size: size ?? ImageSize.v256x256,
          style: style ?? ImageStyle.natural,
        ),
      );
      if (kDebugMode) print(res.data.first.url);
      return res.data.first.url;
    } catch (e) {
      // Log the error or handle it appropriately if running in debug mode
      if (kDebugMode) print('Error generating image: $e');
      return null;
    }
  }
}
