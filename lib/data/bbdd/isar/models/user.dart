
import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
class LocalUser {
  @Index()
  Id? id;

  late String? userName;
  late String? name;
  late String? surnames;
  late String? email;
  late bool isPremium;
  late int tokens;
  late String? photo;
  late String? country;
  late String? gender;
  late int? age;

}
