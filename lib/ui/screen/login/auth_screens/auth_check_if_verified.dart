import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/ui/core/providers/user_verification_provider.dart';

class CheckIfUserIsVerified extends ConsumerWidget {
  static const String route = '/check_if_user_if_verified';
  const CheckIfUserIsVerified({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<bool> isVerified = ref.watch(userVerificationProvider);

    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: Material(
            child: Column(
              children: [
                isVerified.when(
                    data: (data) => 
                    (data == true)
                        ? Expanded(child: Container(height: double.infinity, width: double.infinity, color: Colors.green),)
                        : Expanded(child: Container(height: double.infinity, width: double.infinity, color: Colors.red),),
                    error: (_, __) => Container(),
                    loading: () => const CircularProgressIndicator(
                          color: Colors.amber,
                        ),),
              ],
            ),
          )),
    );
  }
}
