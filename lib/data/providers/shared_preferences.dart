
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/shared_preferences_service.dart';

final sharedPreferencesProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});