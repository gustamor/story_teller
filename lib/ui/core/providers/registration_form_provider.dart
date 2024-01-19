
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/ui/models/registration_form_data_implementation.dart';

final registrationFormProvider = StateProvider<RegistrationFormDataImpl>((ref) {
  return  RegistrationFormDataImpl();
});

