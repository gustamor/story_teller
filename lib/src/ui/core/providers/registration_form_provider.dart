
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/src/ui/models/registration_form_data_impl.dart';

final registrationFormProvider = StateProvider<RegistrationFormDataImpl>((ref) {
  return  RegistrationFormDataImpl();
});
