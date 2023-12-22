import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:story_teller/data/services/auth_services_impl.dart';

/// Notificador de estado para la autenticación.
///
/// Proporciona métodos para iniciar sesión, registrarse y cerrar sesión. Utiliza
/// [AuthenticationServiceImpl] para interactuar con Firebase Auth.
class AuthenticationStateNotifier extends StateNotifier<User?> {
  final AuthenticationServiceImpl _authentication;

  /// Constructor que inicializa el notificador de estado con [AuthenticationServiceImpl].
  AuthenticationStateNotifier(this._authentication) : super(null);

  /// Inicia sesión con correo electrónico y contraseña.
  ///
  /// Utiliza [_authentication.signInWithEmailAndPassword] para autenticar al usuario.
  /// En caso de error, establece el estado a null.
  Future<void> signIn(String email, String password) async {
    try {
      final user =
          await _authentication.signInWithEmailAndPassword(email, password);
      state = user;
    } catch (e) {
      state = null;
      // Manejar el error de inicio de sesión
    }
  }

  /// Registra un nuevo usuario con correo electrónico y contraseña.
  ///
  /// Utiliza [_authentication.createUserWithEmailAndPassword] para crear un nuevo usuario.
  /// En caso de error, establece el estado a null.
  Future<void> signUp(String email, String password) async {
    try {
      final user =
          await _authentication.createUserWithEmailAndPassword(email, password);
      state = user;
    } catch (e) {
      state = null;
      // Manejar el error de registro
    }
  }

  /// Cierra la sesión del usuario actualmente autenticado.
  ///
  /// Utiliza [_authentication.signOut] para cerrar la sesión del usuario.
  Future<void> signOut() async {
    try {
      final success = await _authentication.signOut();
      if (success) {
        state = null;
      }
    } catch (e) {
      // Manejar el error de cierre de sesión
    }
  }

  Future<bool> isUserLogged() async {
    return await _authentication.isUserLogged();
  }
}
