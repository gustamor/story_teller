import 'package:story_teller/src/ui/models/interfaces/registration_form_data.dart';

 class RegistrationFormDataImpl implements RegistrationFormData {
  @override
  bool acceptedTerms = true;

  @override
  late String email;

  @override
  late String password;

  @override
  late String userName;

} 