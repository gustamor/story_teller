import 'package:story_teller/data/models/interfaces/registration_form_data.dart';

class RegistrationFormDataImpl implements RegistrationFormData {
  @override
  bool acceptedTerms = false;

  @override
  late String email;

  @override
  late String password;

  @override
  late String userName;
}
