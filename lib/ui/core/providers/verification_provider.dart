
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final verificationProvider = FutureProvider<bool>((ref) async {
  return await ref
      .read(authenticationStateProvider.notifier)
      .checkIfUserIsVerified();
});