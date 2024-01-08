
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/domain/providers/auth_providers.dart';

final userVerificationProvider = FutureProvider<bool>((ref) async {
  return await ref
      .read(authenticationStateProvider.notifier)
      .checkIfUserIsVerified();
});