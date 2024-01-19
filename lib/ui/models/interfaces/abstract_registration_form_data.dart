/// A data model class representing the form data for user registration.
///
/// This class holds the information entered by the user in the registration form, including email,
/// password, username, and the status of acceptance of terms and conditions.
class RegistrationFormData {
  /// Email address entered by the user.
  ///
  /// This field is expected to be a valid email address that will be used for registration and future communications.
  late String email;

  /// Password entered by the user.
  ///
  /// This field is expected to be a secure password chosen by the user for account protection.
  late String password;

  /// Username entered by the user.
  ///
  /// This field is the user's chosen name for identification within the platform or service.
  late String userName;

  /// Indicates whether the user has accepted the terms and conditions.
  ///
  /// This boolean field represents the user's consent to the terms of service and privacy policy of the platform.
  /// It is initially set to false and should be updated based on the user's action in the registration form.
  bool acceptedTerms = false;

  // You can also add methods for validation or any other operations related to the form data here.
}
