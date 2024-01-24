import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:story_teller/core/params.dart';
import 'package:story_teller/data/di/onesignal_provider.dart';
import 'package:story_teller/data/di/remote_config_service_provider.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/models/dalle_model.dart';
import 'package:story_teller/domain/abstract/services/abstract_tell_logger.dart';
import 'package:story_teller/firebase_options.dart';

class Init {
  messaging(WidgetRef ref) {
    ref.read(oneSignalProvider);
  }

  firebase() async {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

 

  void configureDio() {
    // Set default configs
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.receiveTimeout = const Duration(seconds: 20);
  }

  setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  static TellLogger logger() {
    return LogImpl();
  }

  void admob(){
    MobileAds.instance.initialize();
  }
}
