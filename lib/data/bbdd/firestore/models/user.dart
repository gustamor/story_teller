
class User {
  final String? email;
  final String? photo;
  final String? userName;
  final String? name;
  final String? surnames;
  final String? country;
  final String? gender;
  final int? age;
  final String? uuid;

  User({
    this.email,
    this.photo,
    this.userName,
    this.name,
    this.surnames,
    this.country,
    this.gender,
    this.age,
    this.uuid,
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
      uuid: uuid ?? this.uuid,
    );
  }

  factory User.fromFirestore(Map<String, dynamic> firestoreData) {
    return User(
      email: firestoreData['email'] as String?,
      photo: firestoreData['photo'] as String?,
      userName: firestoreData['user_name'] as String?,
      name: firestoreData['name'] as String?,
      surnames: firestoreData['surnames'] as String?,
      country: firestoreData['country'] as String?,
      gender: firestoreData['gender'] as String?,
      age: firestoreData['age'] as int?,
      uuid: firestoreData['uuid'] as String?,
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
      'uuid': uuid,
    };
  }

  @override
  String toString() {
    return 'User(email: $email, photo: $photo, userName: $userName, name: $name, surnames: $surnames, country: $country, gender: $gender, age: $age, uuid: $uuid)';
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
      other.uuid == uuid;
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
      uuid.hashCode;
  }
}