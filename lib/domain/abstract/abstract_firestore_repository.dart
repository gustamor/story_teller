import 'package:story_teller/data/sources/bbdd/firestore/models/simple_story.dart';

/// Abstract class defining the interface for Firestore repository operations.
///
/// Specifies methods for uploading, updating, and fetching tales from Firestore.
abstract class AbstractFireStoreRepository {
  /// Uploads a tale to Firestore.
  ///
  /// Parameters:
  ///   [story]: The tale to be uploaded.
  Future<void> uploadTale(Story story);

  /// Updates an existing tale in Firestore.
  ///
  /// Parameters:
  ///   [story]: The tale with updated information.
  Future<void> updateTale(Story story);

  /// Fetches all tales from Firestore.
  ///
  /// Returns:
  ///   A list of [Story] objects representing all fetched tales.
  Future<List<Story>> getAllTales();

  /// Fetches a specific tale from Firestore based on its ID.
  ///
  /// Parameters:
  ///   [id]: The ID of the tale to be fetched.
  ///
  /// Returns:
  ///   A [Story] object representing the fetched tale.
  Future<Story> getTale(String id);
}