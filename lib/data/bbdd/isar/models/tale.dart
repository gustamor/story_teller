import 'package:isar/isar.dart';

part 'tale.g.dart';

@Collection()
class Tale {
  @Index(unique: true)
  Id? id;
   String? uuid;
   String? title;
  // late DocumentReference?  speech; // Referencia al documento Speech
   String? idUser;
   String? story;
   DateTime? date;
   String? prompt;
   String? imageUrl;
}
