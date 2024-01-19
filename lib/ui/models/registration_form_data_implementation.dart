import 'package:story_teller/ui/models/interfaces/abstract_registration_form_data.dart';

/// An implementation of the [RegistrationFormData] interface.
///
/// This class provides concrete implementations for the fields and behaviors defined in the [RegistrationFormData] interface.
/// It represents the form data for user registration and can be extended or modified to include additional functionality or validation logic.
class RegistrationFormDataImpl implements RegistrationFormData {
  
  /// Indicates whether the user has accepted the terms and conditions.
  ///
  /// In this implementation, the default value is set to true, indicating that the user has accepted the terms by default.
  /// This behavior can be adjusted based on the specific requirements of the registration process.
  @override
  bool acceptedTerms = true;

  /// Email address entered by the user.
  ///
  /// This field is expected to be a valid email address that will be used for registration and future communications.
  @override
  late String email;

  /// Password entered by the user.
  ///
  /// This field is expected to be a secure password chosen by the user for account protection.
  @override
  late String password;

  /// Username entered by the user.
  ///
  /// This field is the user's chosen name for identification within the platform or service.
  @override
  late String userName;

}
