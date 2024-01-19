import 'package:firestore_ref/firestore_ref.dart';
import 'package:story_teller/domain/models/abstract_user.dart';

/// Defines the contract for user-related operations.
///
/// This abstract class outlines the properties and methods that any user entity should implement.
/// It includes common user attributes, serialization methods, and utility functions.
class User implements AbstractUser {
  @override
  final String? email;
  @override
  String? photo;
  @override
  String? userName;
  @override
  final String? name;
  @override
  String? surnames;
  @override
  String? country;
  @override
  String? gender;
  @override
  Timestamp? birthDate;
  @override
  final String? id;
  @override
  bool? isPremium;
  @override
  int? tokens;

  /// Constructs a [User] instance with the specified attributes.
  @override
  User({
    this.email,
    this.photo,
    this.userName,
    this.name,
    this.surnames,
    this.country,
    this.gender,
    this.birthDate,
    this.id,
    this.isPremium,
    this.tokens,
  });

  /// Returns a new [User] instance with updated attributes. Unspecified attributes default to current values.
  @override
  User copyWith({
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
  }) {
    return User(
      email: email ?? this.email,
      photo: photo ?? this.photo,
      userName: userName ?? this.userName,
      name: name ?? this.name,
      surnames: surnames ?? this.surnames,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      id: id ?? this.id,
      tokens: tokens ?? this.tokens,
    );
  }

  /// Creates a [User] instance from Firestore [snapshot] data.
  ///
  /// Utilizes [SnapshotOptions] for optional configuration.
  @override
  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final firestoreData = snapshot.data();

    return User(
      email: firestoreData?['email'] as String?,
      photo: firestoreData?['photo'] as String?,
      userName: firestoreData?['user_name'] as String?,
      name: firestoreData?['name'] as String?,
      surnames: firestoreData?['surnames'] as String?,
      country: firestoreData?['country'] as String?,
      gender: firestoreData?['gender'] as String?,
      birthDate: firestoreData?['birthDate'] as Timestamp?,
      id: firestoreData?['id'] as String?,
      tokens: firestoreData?['tokens'] as int?,
    );
  }

  /// Converts the [User] instance to a Map suitable for Firestore storage.
  @override
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'photo': photo,
      'user_name': userName,
      'name': name,
      'surnames': surnames,
      'country': country,
      'gender': gender,
      'birthDate': birthDate,
      'id': id,
      'tokens': tokens,
    };
  }

  /// Creates a [User] instance from a Map of key/value pairs.
  ///
  /// Expects a map with user-related keys and extracts values to create a [User] instance.
  @override
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String?,
      photo: map['photo'] as String?,
      userName: map['user_name'] as String?,
      name: map['name'] as String?,
      surnames: map['surnames'] as String?,
      country: map['country'] as String?,
      gender: map['gender'] as String?,
      birthDate: map['birthDate'] as Timestamp?,
      id: map['id'] as String?,
      tokens: map['tokens'] as int?,
    );
  }

  /// Converts the [User] instance to a Map of key/value pairs for serialization or storage.
  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'photo': photo,
      'user_name': userName,
      'name': name,
      'surnames': surnames,
      'country': country,
      'gender': gender,
      'birthDate': birthDate,
      'id': id,
      'tokens': tokens,
    };
  }

  /// Returns a string representation of the [User] instance, useful for debugging and logging.
  @override
  String toString() {
    return 'User(email: $email, photo: $photo, userName: $userName, name: $name, surnames: $surnames, country: $country, gender: $gender, birthDate: $birthDate, id: $id, tokens: $tokens)';
  }

  /// Determines if two [User] instances are equal based on their attributes.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.email == email &&
        other.photo == photo &&
        other.userName == userName &&
        other.name == name &&
        other.surnames == surnames &&
        other.country == country &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.id == id &&
        other.tokens == tokens;
  }

  /// Generates a hash code based on the attributes of the [User] instance.
  @override
  int get hashCode {
    return email.hashCode ^
        photo.hashCode ^
        userName.hashCode ^
        name.hashCode ^
        surnames.hashCode ^
        country.hashCode ^
        gender.hashCode ^
        birthDate.hashCode ^
        id.hashCode ^
        tokens.hashCode;
  }
}
