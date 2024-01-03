import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/providers/story_orchestator_provider.dart';

class TextWithState extends ConsumerWidget {
  const TextWithState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(storyProcessOrchestratorProvider);
   
    return Text(notifications.step.toString()); // Actualiza tu UI aquí
  }
}
