import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/services/logger_impl.dart';
import 'package:story_teller/src/domain/services/abstract_riverpod_logger.dart';
import 'package:story_teller/src/domain/services/abstract_tell_logger.dart';
/// `LoggerRiverpod` is a class that implements `RiverpodLogger`.
/// It provides implementations for provider observation methods.
class LoggerRiverpod implements RiverpodLogger {
  final TellLogger log = LogImpl();

  /// `didUpdateProvider` is invoked when a provider is updated.
  ///
  /// [provider] is the provider that was updated.
  /// [previousValue] is the previous value of the provider.
  /// [newValue] is the new value of the provider.
  /// [container] is the provider container associated with the provider.
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.d(
        "didUpdateProvider => Provider: $provider, PreviousValue: $previousValue, NewValue: $newValue, Container: $container");
  }

  /// `didAddProvider` is invoked when a new provider is added.
  ///
  /// [provider] is the provider that was added.
  /// [value] is the value of the provider.
  /// [container] is the provider container associated with the provider.
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    log.d(
        "didAddProvider => Provider: $provider, Value: $value, Container: $container");
  }

  /// `didDisposeProvider` is invoked when a provider is disposed.
  ///
  /// [provider] is the provider that was disposed.
  /// [container] is the provider container associated with the provider.
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    log.d("didDisposeProvider => Provider: $provider, Container: $container");
  }

  /// `providerDidFail` is invoked when a provider fails.
  ///
  /// [provider] is the provider that failed.
  /// [error] is the error that occurred.
  /// [stackTrace] is the error's stack trace.
  /// [container] is the provider container associated with the provider.
  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    log.d(
        "providerDidFail => Provider: $provider, Error: $error, StackTrace: $stackTrace, Container: $container");
  }
}