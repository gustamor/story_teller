
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

//image = ["uuid", "imageurl"];
final upateStoryWithImageUrl =
    FutureProvider.family<void, List<String>>((ref, image) async {
  final db = ref.read(firebaseFirestoreProvider);
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  try {
    final docRef = db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .doc(image[0]);
    db.runTransaction((transaction) async {
      //final docSnapshot = await transaction.get(docRef);
      // final imageUrl = docSnapshot.get("imageUrl");
      transaction.update(docRef, {"imageUrl": image[1]});
    }).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"),
    );
  } on FirebaseException catch (e) {
    print("Error updating story from Firebase: $e");
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
});
