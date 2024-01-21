import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

final oneSignalProvider = Provider<void>((ref) {
  if (kDebugMode) {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }
  OneSignal.initialize(dotenv.env['ONESIGNAL']!);
  OneSignal.Notifications.requestPermission(true);
  OneSignal.Location.requestPermission();
  final notifications = OneSignalNotifications();


  notifications.addForegroundWillDisplayListener((event) {
   // final notification = event.notification;
    //print("AAA${notification.additionalData}");
  });


});
