import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/providers/story_orchestator_provider.dart';

/// A widget that displays text based on the current state of a specific notifier.
///
/// This widget uses the [ConsumerWidget] to listen to changes in the state of [storyProcessOrchestratorProvider]
/// and updates the UI accordingly. It displays the current step in the story process as text.
class TextWithState extends ConsumerWidget {
  /// Constructs a [TextWithState] widget.
  const TextWithState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watches the [storyProcessOrchestratorProvider] and rebuilds the widget whenever the notifier updates the state.
    final notifications = ref.watch(storyProcessOrchestratorProvider);
    
    // The UI is updated here to display the current step of the story process.
    return Text(notifications.step.toString()); // Updates your UI here based on the current step.
  }
}
