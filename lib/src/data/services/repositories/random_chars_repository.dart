import 'dart:math';

class RandomNames {}

class RandomRepository {
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
