import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/repositories/openai/dalle_image.dart';
import 'package:story_teller/data/services/image_service.dart';
import 'package:story_teller/di/openai_providers.dart';
import 'package:story_teller/domain/image_controller.dart';
import 'package:story_teller/domain/image_process.dart';

final imageProcessOrchestratorProvider =
    StateNotifierProvider<ImageProcessController, ImageProcessState>((ref) {
  final ImagesService imgService = ImagesService();
  late final DalleImage dalle = ref.watch(dalleProvider);
  return ImageProcessController(ref, dalle, imgService);
});
