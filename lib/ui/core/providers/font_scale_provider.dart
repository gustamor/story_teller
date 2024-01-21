import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/di/shared_preferences.dart';

final fontScaleNotifierProvider =
    StateNotifierProvider<FontScaleStateNotifier, double>((ref) {
  return FontScaleStateNotifier(ref);
});

class FontScaleStateNotifier extends StateNotifier<double> {
  final Ref ref;

  FontScaleStateNotifier(this.ref) : super(1.4);

  Future<void> saveFontScale(double newFontScale) async {
    await ref
        .watch(sharedPreferencesProvider)
        .setDouble('fontScale', newFontScale);
    state = newFontScale;
  }

  Future<void> loadFontScale() async {
    final fontScale =
        await ref.watch(sharedPreferencesProvider).getDouble('fontScale');
    state = fontScale;
  }
}
