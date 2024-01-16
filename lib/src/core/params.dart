import 'package:openai_dart/openai_dart.dart';
import 'package:story_teller/src/domain/models/dalle_model.dart';

class Params {
  static String Oak = "";
  static String gptPrompt = "";
  static String gptModel = "gpt-3.5-turbo";
  static DalleModel dalleModel = DalleModel(
      model: ImageModels.dallE2,
      quality: ImageQuality.standard,
      size: ImageSize.v256x256,
      style: ImageStyle.vivid);
}
