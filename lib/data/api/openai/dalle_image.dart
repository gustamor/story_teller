import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/di/openai_providers.dart';

class DalleImage {
  Ref ref;
  DalleImage(this.ref);
  Future<String?> generateImageLink(
      {required String prompt,
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
