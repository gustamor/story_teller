import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/sources/bbdd/firestore/actions/user/fetch_firestore_user.dart';

final fetchUserNameAndSurnameFromIdProvider = StreamProvider<String>((ref) async* {
  String? name;
  String? surname;
  String email = "";
  String tag;
  try {
    final currentUserDocRef = ref.watch(userProvider);
    currentUserDocRef.when(
        data: (user) {
          name = user!.name;
          surname = user.surnames;
          email = user.email!;
        },
        error: (_, __) {},
        loading: () {});

    if (name == null && surname == null) {
      tag = email;
    }
    tag = "${name ?? ""} ${surname ?? ""}";

    yield tag;
  } catch (e) {
    throw Exception(e);
  }
});
