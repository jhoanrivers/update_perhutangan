import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      firebaseMessaging
          .requestNotificationPermissions(IosNotificationSettings());
    }

    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('On message $message');
    }, onResume: (Map<String, dynamic> resume) async {
      print('On resume $resume');
    }, onLaunch: (Map<String, dynamic> launch) async {
      print('on launch $launch');
    });
  }
}
