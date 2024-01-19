import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/core/params.dart';
import 'package:story_teller/data/di/onesignal_provider.dart';
import 'package:story_teller/data/di/remote_config_service_provider.dart';
import 'package:story_teller/data/services/logger_impl.dart';
import 'package:story_teller/domain/models/dalle_model.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

class Init {
  messaging(WidgetRef ref) {
    ref.read(oneSignalProvider);
  }

  remoteConfig(WidgetRef ref) async {
    try {
      final remoteConfig = await ref.watch(remoteConfigProvider.future);
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
  /// Implements a [TellLogger] instance
}
