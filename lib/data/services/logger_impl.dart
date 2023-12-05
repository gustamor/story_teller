
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:story_teller/domain/services/tell_logger.dart';

class LogImpl implements TellLogger {
  @override
  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true),
  );

  @override
  void i(dynamic message) {
    logger.i(message);
  }

  @override
  void d(dynamic message) {
    if (kDebugMode) {
      logger.d(message);
    }
  }

  @override
  void e(dynamic message) {
    if (kDebugMode) {
      logger.e(message);
    }
  }
}
