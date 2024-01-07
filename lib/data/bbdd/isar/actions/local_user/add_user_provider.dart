import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/bbdd/isar/actions/local_user/add_email_to_user_provider.dart';
import 'package:story_teller/data/bbdd/isar/actions/local_user/add_username_provider.dart';
import 'package:story_teller/ui/core/providers/registration_form_provider.dart';

final addUserProvider = FutureProvider.autoDispose<void>((ref) async {
  try {
    final email = ref.read(registrationFormProvider).email;
    final userName = ref.read(registrationFormProvider).userName;

    ref.read(
      addUserNameProvider(
        userName,
      ),
    );
    ref.read(
      addEmailNameProvider(
        email,
      ),
    );
  } catch (e) {
    throw Exception(e);
  }
});
