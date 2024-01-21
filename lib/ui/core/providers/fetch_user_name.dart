import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/network/api/firestore/user/fetch_firestore_user.dart';

final fetchUserNameProvider = StreamProvider<String>((ref) async* {
  String? name = "";
  String email = "";
  String tag;
  try {
    final currentUserDocRef = ref.watch(userProvider);
    currentUserDocRef.when(
        data: (user) {
          name = user!.name;
          email = user.email!;
        },
        error: (_, __) {},
        loading: () {});

    if (name == null) {
      tag = email;
    }
    tag = "$name";

    yield tag;
  } catch (e) {
    throw Exception(e);
  }
});
