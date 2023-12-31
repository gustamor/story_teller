
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/ui/core/providers/image_process_provider.dart';

class TextWithState extends ConsumerWidget {
  const TextWithState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageProcessOrchestratorProvider);
    return Text(state.step.name); // Actualiza tu UI aquí
  }
}