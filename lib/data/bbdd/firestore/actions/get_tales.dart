import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/constants.dart';
import 'package:story_teller/data/bbdd/firestore/models/simple_story.dart';
import 'package:story_teller/data/di/firebase_providers.dart';
import 'package:story_teller/domain/providers/auth_providers.dart';

final getTalesProvider = FutureProvider<List<Story>>((ref) async {
  final db = ref.read(firebaseFirestoreProvider);
  final currentUser = await ref.read(authenticationProvider).getCurrentUser();

  List<Story> stories = [];
  try {
    var storiesCollection = await db
        .collection(Collections.kUsers)
        .doc(currentUser!.uid)
        .collection(Collections.kStories) // Genera la consulta
        .withConverter(
          fromFirestore: Story.fromFirestore,
          toFirestore: (Story story, _) => story.toFirestore(),
        ) // Intercala un conversor Map <-> Story para cuando envía la petición
        // y para cuando recibe la respuesta.
        .get(); // Recibe el resultado de la consulta.

    for (var storySnapshot in storiesCollection.docs) {
      final story = storySnapshot.data();
      stories.add(story);
    }
    return stories;
  } on FirebaseException catch (e) {
    print("Error fetching stories from Firebase: $e");
    throw Exception(e);
  } catch (e) {
    throw Exception(e);
  }
});
