
import 'package:firestore_ref/firestore_ref.dart';


/// An abstract class representing a user entity.
///
/// This class provides the structure for user data, including basic
/// information like email, photo, name, and other relevant properties.
/// It serves as a blueprint for concrete user implementations and data handling.
abstract class AbstractUser {
  /// The email address of the user.
  String? get email;

  /// The photo URL of the user.
  String? get photo;

  /// The username of the user.
  String? get userName;

  /// The first name of the user.
  String? get name;

  /// The surname(s) of the user.
  String? get surnames;

  /// The country of the user.
  String? get country;

  /// The gender of the user.
  String? get gender;

  /// The birth date of the user represented as a [Timestamp].
  Timestamp? get birthDate;

  /// The unique identifier of the user.
  String? get id;

  /// Indicates whether the user has a premium account.
  bool? get isPremium;

  /// The number of tokens associated with the user.
  int? get tokens;

  /// Creates a copy of this user with modified fields.
  ///
  /// This method allows for copying the user object while changing specified
  /// fields. All parameters are optional.
  AbstractUser copyWith({
    String? email,
    String? photo,
    String? userName,
    String? name,
    String? surnames,
    String? country,
    String? gender,
    Timestamp? birthDate,
    String? id,
    bool? isPremium,
    int? tokens,
  });

  /// Constructs a user from a Firestore snapshot.
  ///
  /// This factory constructor creates an instance of [AbstractUser] from
  /// a Firestore [DocumentSnapshot]. The [options] parameter may contain
  /// specific options for the snapshot.
  AbstractUser.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  );

  /// Converts the user object to a Firestore-compatible data map.
  ///
  /// This method serializes the user's data into a map format that is
  /// compatible with Firestore storage.
  Map<String, dynamic> toFirestore();

  /// Constructs a user from a map of key-value pairs.
  ///
  /// This factory constructor initializes the properties of the [AbstractUser]
  /// with values from the provided [map].
  AbstractUser.fromMap(Map<String, dynamic> map);

  /// Converts the user object to a map of key-value pairs.
  ///
  /// This method serializes the user's data into a standard map format.
  Map<String, dynamic> toMap();

  /// Returns a string representation of the user object.
  ///
  /// This method provides a textual representation of the user's data,
  /// typically used for debugging purposes.
  @override
  String toString();

  /// Compares this instance with another object for equality.
  ///
  /// Returns `true` if the [other] object is an instance of [AbstractUser] and
  /// has the same data values.
  @override
  bool operator ==(Object other);

  /// Generates a hash code for this user instance.
  ///
  /// The hash code is computed based on the user's properties and is used
  /// for efficient comparison and indexing in collections.
  @override
  int get hashCode;
}