
import 'package:logger/logger.dart';

/// Abstract class for logging messages.
///
/// Provides a framework for implementing a logging system with different levels of
/// logging, such as info, error, and debug. This class uses the [Logger] class for
/// the underlying logging mechanism.
abstract class TellLogger {
  /// The logger instance used for actual logging operations.
  final Logger logger = Logger();

  /// Logs an informational message.
  ///
  /// Implementations should use this method to log messages that provide general
  /// information about the application's execution. The [message] can be any dynamic
  /// type, allowing for flexibility in what can be logged.
  void i(dynamic message);

  /// Logs an error message.
  ///
  /// Implementations should use this method for logging error messages that indicate
  /// failures or issues in the application. Similar to [i], the [message] can be of any
  /// dynamic type to accommodate various error information.
  void e(dynamic message);

  /// Logs a debug message.
  ///
  /// Use this method for logging messages useful in a debugging context. These messages
  /// might contain detailed information about the application's state or execution flow.
  /// The [message] can be of any dynamic type, providing flexibility in debug logging.
  void d(dynamic message);
}
