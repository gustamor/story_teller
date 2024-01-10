import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/local_user/add_email_to_user.dart';
import 'package:story_teller/src/data/sources/bbdd/isar/actions/local_user/add_username.dart';
import 'package:story_teller/src/ui/core/providers/registration_form_provider.dart';

final addUser = FutureProvider.autoDispose<void>((ref) async {
  try {
    final email = ref.read(registrationFormProvider).email;
    final userName = ref.read(registrationFormProvider).userName;

    ref.read(
      addUserName(
        userName,
      ),
    );
    ref.read(
      addEmailName(
        email,
      ),
    );
  } catch (e) {
    throw Exception(e);
  }
});
