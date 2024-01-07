import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/data/di/openai_provider.dart';

/// Represents the generation of images using the DALL-E AI model.
///
/// This class manages the interaction with an AI model to create images based
/// on provided text prompts. It uses a [Ref] instance to interact with
/// other objects and services.

class DalleImage {
  /// Reference to other objects managed by the provider.
  Ref ref;

  /// Constructor to create [DalleImage] with a given [ref].
  DalleImage(this.ref);

  /// Asynchronously generates an image link based on the provided prompt.
  ///
  /// Utilizes the OpenAI API to create an image corresponding to the [prompt].
  /// Optional parameters [model], [size], and [style] can be provided to
  /// customize the image generation. If not provided, defaults are used.
  /// Returns the URL of the generated image.
  ///
  /// The [model] parameter specifies the DALL-E model version to use.
  /// The [size] parameter determines the resolution of the generated image.
  /// The [style] parameter allows selection of the image style.
  ///
  /// If [kDebugMode] is enabled, the image URL is printed to the console.
  ///
  /// Returns the URL of the generated image, or `null` if no image is generated.
  Future<String?> generateImageLink({
      required String prompt,
      required ImageModels? model,
      ImageSize? size,
      ImageStyle? style}) async {
    final client = ref.watch(openAiProvider);
    final ImagesResponse res = await client.createImage(
          request: CreateImageRequest(
        model: CreateImageRequestModel.model(model ?? ImageModels.dallE2),
        prompt: prompt,
        quality: ImageQuality.standard,
        size: size ?? ImageSize.v256x256,
        style: ImageStyle.natural,
      ),
    );
    if (kDebugMode) print(res.data.first.url);
    return res.data.first.url;
  }
}
