import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class AppBootstrap {
  static Future<void> init() async {
    // 🔑 Register token refresh ONCE
    listenTokenRefresh();

    // 🔔 Foreground message
    FirebaseMessaging.onMessage.listen((message) {
      if (FirebaseAuth.instance.currentUser == null) return;

      LocalNotificationService.show(
        title: message.notification?.title ?? "TeamoMart",
        body: message.notification?.body ?? "",
        payload: message.data,
      );
    });
  }


  static void listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update({"fcmToken": newToken});
    });
  }

}
