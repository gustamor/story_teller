import 'package:google_mobile_ads/google_mobile_ads.dart';

abstract class AbstractAdmobServices {
  final int maxFailedLoadAttempts = 3;
  final AdRequest request = const AdRequest();
  InterstitialAd? interstitialAd;
  int numInterstitialLoadAttempts = 0;
  void createInterstitialAd();
  void showInterstitialAd();
}
