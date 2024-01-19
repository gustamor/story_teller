import 'package:flutter_riverpod/flutter_riverpod.dart';

final genresListProvider = Provider<List<String>>((ref) {
  List<String> genres = [
    "fantasy",
    "science_fiction",
    "mystery",
    "horror",
    "romance",
    "adventure",
    "suspense",
    "historical",
    "comedy",
    "drama",
    "fairy_tale",
    "dystopia",
    "magical_realism",
    "mythological",
    "crime",
    "supernatural",
    "steampunk",
    "cyberpunk",
    "satire",
    "western",
    "psychological_thriller",
    "urban_fantasy",
    "realism",
    "post_apocalyptic_science_fiction",
    "spy_novel",
    "parody",
    "fable",
    "space_opera",
    "military_science_fiction"
  ];
  return genres;
});
