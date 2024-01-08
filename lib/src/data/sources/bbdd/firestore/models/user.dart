import 'package:firestore_ref/firestore_ref.dart';

class User {
  final String? email;
  String? photo;
  String? userName;
  final String? name;
  String? surnames;
  String? country;
  String? gender;
  int? age;
  final String? id;
  bool? isPremium;
  int? tokens;

  User({
    this.email,
    this.photo,
    this.userName,
    this.name,
    this.surnames,
    this.country,
    this.gender,
    this.age,
    this.id,
    this.isPremium,
    this.tokens,
  });

  User copyWith({
    String? email,
    String? photo,
    String? userName,
    String? name,
    String? surnames,
    String? country,
    String? gender,
    int? age,
    String? uuid,
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
      age: age ?? this.age,
      id: uuid ?? id,
      tokens: tokens ?? this.tokens,
    );
  }

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
      age: firestoreData?['age'] as int?,
      id: firestoreData?['uuid'] as String?,
      tokens: firestoreData?['tokens'] as int?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'photo': photo,
      'user_name': userName,
      'name': name,
      'surnames': surnames,
      'country': country,
      'gender': gender,
      'age': age,
      'uuid': id,
      'tokens': tokens,
    };
  }
factory User.fromMap(Map<String, dynamic> map) {
  return User(
    email: map['email'] as String?,
    photo: map['photo'] as String?,
    userName: map['user_name'] as String?,
    name: map['name'] as String?,
    surnames: map['surnames'] as String?,
    country: map['country'] as String?,
    gender: map['gender'] as String?,
    age: map['age'] as int?,
    id: map['uuid'] as String?,
    tokens: map['tokens'] as int?,
  );
}
Map<String, dynamic> toMap() {
  return {
    'email': email,
    'photo': photo,
    'user_name': userName,
    'name': name,
    'surnames': surnames,
    'country': country,
    'gender': gender,
    'age': age,
    'uuid': id,
    'tokens': tokens,
  };
}
  @override
  String toString() {
    return 'User(email: $email, photo: $photo, userName: $userName, name: $name, surnames: $surnames, country: $country, gender: $gender, age: $age, uuid: $id, tokens: $tokens)';
  }

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
        other.age == age &&
        other.id == id &&
        other.tokens == tokens;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        photo.hashCode ^
        userName.hashCode ^
        name.hashCode ^
        surnames.hashCode ^
        country.hashCode ^
        gender.hashCode ^
        age.hashCode ^
        id.hashCode ^
        tokens.hashCode;
  }
}
