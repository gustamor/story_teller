import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/bbdd/firestore/actions/get_tales.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final getTaleProvider = FutureProvider.family<Story, String>((ref, id) async {
  final db = ref.read(firebaseFirestoreProvider);
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();
  try {
    final docRef = db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories)
        .doc(id)
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        );
    final docSnap = await docRef.get();
    final story = docSnap.data();
    return story!;
  } on FirebaseException catch (e) {
    print("Error fetching story from Firebase: $e");
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
});
