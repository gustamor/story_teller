
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/models/registration_form_data.dart';

final registrationFormProvider = StateProvider<RegistrationFormDataImpl>((ref) {
  return RegistrationFormDataImpl() ;
});

