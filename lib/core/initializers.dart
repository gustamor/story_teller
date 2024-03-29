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

  remoteConfig(WidgetRef ref) async {
    try {
      final remoteConfig = await ref.watch(remoteConfigProvider.future);
      Params.oakey = await remoteConfig.getStringValue("openAiKey");
      Params.oaorg = await remoteConfig.getStringValue("openAiOrganization");
      Params.jpgQuality = await remoteConfig.getIntValue("jpq_quality");
      Params.gptModel = await remoteConfig.getStringValue("gtp_model");
      Params.gptPrompt = await remoteConfig.getStringValue("gtp_prompt");
      final dalleRemote = await remoteConfig.getStringValue("dalle");
      Params.dalleModel = DalleModel.fromMap(
        json.decode(
          dalleRemote,
        ),
      );
      // ignore: empty_cdalleModelatches
    } catch (e) {
      throw Exception(e);
    }
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
