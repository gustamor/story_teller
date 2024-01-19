
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:story_teller/domain/services/abstract_tell_logger.dart';

/// Logger implementation using the Logger package.
///
/// Provides a customized logger for different levels of logging (info, debug, and error).
/// Implements the [TellLogger] interface.
class LogImpl implements TellLogger {
  /// Logger instance from the Logger package configured with PrettyPrinter for formatted output.
  @override
  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed in stack trace
        errorMethodCount: 8, // Number of method calls if stacktrace is provided for error
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: true), // Print the time for each log message
  );

  /// Logs an informational message [message].
  ///
  /// This can be used for general-purpose logging of informational messages.
  @override
  void i(dynamic message) {
    logger.i(message);
  }

  /// Logs a debug message [message].
  ///
  /// This is used for logging detailed debug information. The logs are only printed in debug mode.
  @override
  void d(dynamic message) {
    if (kDebugMode) {
      logger.d(message);
    }
  }

  /// Logs an error message [message].
  ///
  /// This is used for logging error messages. The logs are only printed in debug mode.
  @override
  void e(dynamic message) {
    if (kDebugMode) {
      logger.e(message);
    }
  }
}
