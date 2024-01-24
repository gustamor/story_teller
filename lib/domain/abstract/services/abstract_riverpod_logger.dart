
import 'package:flutter_riverpod/flutter_riverpod.dart';
/// `RiverpodLogger` is an abstract class that extends `ProviderObserver`.
/// It defines methods for observing changes in providers.
/// 
abstract class RiverpodLogger extends ProviderObserver {
  
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
  );

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
  );

  /// `didDisposeProvider` is invoked when a provider is disposed.
  ///
  /// [provider] is the provider that was disposed.
  /// [container] is the provider container associated with the provider.
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer container,
  );
}