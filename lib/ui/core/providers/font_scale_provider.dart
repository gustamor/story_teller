import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/di/shared_preferences.dart';

final fontScaleNotifierProvider =
    StateNotifierProvider<FontScaleStateNotifier, double>((ref) {
  return FontScaleStateNotifier(ref)..loadFontScale();
});

class FontScaleStateNotifier extends StateNotifier<double> {
  final Ref ref;

  FontScaleStateNotifier(this.ref) : super(0.0);

  Future<void> saveFontScale(double newFontScale) async {
    await ref
        .read(sharedPreferencesProvider)
        .setDouble('fontScale', newFontScale);
    state = newFontScale;
  }

  Future<void> loadFontScale() async {
    final fontScale =
        await ref.read(sharedPreferencesProvider).getDouble('fontScale');
    state = fontScale;
  }
}
