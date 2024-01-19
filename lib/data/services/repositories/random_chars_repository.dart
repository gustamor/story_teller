import 'dart:math';

/// Repository for generating random strings.
///
/// This class offers functionalities related to random string generation, useful for
/// creating unique identifiers, tokens, etc.
class RandomRepository {
  
  /// Generates a random string of a specified [length].
  ///
  /// The generated string consists of alphanumeric characters (both uppercase and lowercase) 
  /// and has a length defined by the [longitud] parameter. This method uses the Dart `Random`
  /// class to ensure variability in the generated string.
  /// 
  /// Parameters:
  ///   - [longitud]: The length of the random string to be generated.
  ///
  /// Returns:
  ///   A random string with the specified [longitud].
  String generateRandomString(int longitud) {
    const caracteres =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        longitud,
        (_) => caracteres.codeUnitAt(
          rnd.nextInt(
            caracteres.length,
          ),
        ),
      ),
    );
  }
}
