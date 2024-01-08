// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: unused_import, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/flutter_driver.dart' as flutte_driver;
import 'package:flutter_test/flutter_test.dart';
import 'package:story_teller/src/ui/screen/login/auth_screens/auth_screen.dart';
import 'package:flutter_test/flutter_test.dart' as test;

void main() async {
  enableFlutterDriverExtension();

  test.group('Prueba de Integración', () {
     flutte_driver.FlutterDriver? driver;

    setUpAll(() async {
      driver = await flutte_driver.FlutterDriver.connect(
        // dartVmServiceUrl is a URL used for connecting to the Dart VM service,
        // which is a debugging and profiling service provided by the Dart runtime.
        dartVmServiceUrl: "ws://127.0.0.1:58557/lTla2qH-HXs=/ws",
        printCommunication: true, // Print communication logs for debugging.
      );
    /*  // Configurar el emulador de Firestore
      FirebaseFirestore.instance.settings = const Settings(
        host: 'localhost:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );*/

      // Configurar el emulador de Auth
      await FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
    });

    tearDownAll(() async {
      await driver?.close();
    });

    test.test('login with Firebase Auth', () async {
      // Identificadores de los widgets
      final emailFieldFinder = find.byKey(const Key('emailField'));
      final passwordFieldFinder = find.byKey(const Key('passwordField'));
      final loginButtonFinder = find.byKey(const Key('loginButton'));
      final createAccountButtonFinder =
          find.byKey(const Key('createAccountButton'));

      // Ingresar credenciales de prueba
      await driver?.tap(emailFieldFinder as flutte_driver.SerializableFinder);
      await driver?.enterText('pepe@aa.com');
 

      await driver?.tap(passwordFieldFinder as flutte_driver.SerializableFinder);
      await driver?.enterText('abdefgh1');

      // Iniciar sesión
      await driver?.tap(loginButtonFinder as flutte_driver.SerializableFinder);

      // Verificar que la pantalla cambió a CreateAccount
      await driver?.waitFor(
          createAccountButtonFinder as flutte_driver.SerializableFinder);
    });
    // Test for a valid email address
    test.test('Valid email', () {
      // Arrange: Create a validator function for email validation
      final emailFieldFinder = find.byKey(const Key('emailField'));

      final result = AuthScreen().validateEmail('pepe@aa.com');

      // Act: Invoke the validator with a valid email

      // Assert: Ensure the result is null, indicating a valid email
      expect(result, false);
    });
  });
}
