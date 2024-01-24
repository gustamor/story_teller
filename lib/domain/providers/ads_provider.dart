import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/di/admob_provider.dart';

final intertitialCreateProvider = Provider<void>(
  (ref) {
    try {
      final admob = ref.watch(
        admobServicesProvider,
      );
      return admob.createInterstitialAd();
    } catch (e) {
      rethrow;
    }
  },
);

final intertitialShowProvider = Provider<void>(
  (ref) {
    try {
      final admob = ref.watch(
        admobServicesProvider,
      );
      return admob.showInterstitialAd();
    } catch (e) {
      rethrow;
    }
  },
);
