import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/logger_impl.dart';

class LoggerRiverpod extends ProviderObserver {
  final log = LogImpl();
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.d(
        "didUpdateProvider => Provider: $provider, PreviousValue: $previousValue,newValue: $newValue, Container: $container");
  }

  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    log.d(
        "didAddProvider => provider: $provider, Value: $value, container: $container");
  }

  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  ) {
    log.d("didDisposeProvider => provider: $provider, container: $container");
  }
}
