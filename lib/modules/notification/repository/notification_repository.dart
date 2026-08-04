import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepository {
  NotificationRepository._();

  static final NotificationRepository instance =
  NotificationRepository._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initialize() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print("Notification Permission: ${settings.authorizationStatus}");

    await _saveToken();

    FirebaseMessaging.instance.onTokenRefresh.listen(
          (token) async {
        await _updateToken(token);
      },
    );
  }

  Future<void> _saveToken() async {
    final token = await _messaging.getToken();

    if (token == null) return;

    await _updateToken(token);
  }

  Future<void> _updateToken(
      String token,
      ) async {
    final uid = _auth.currentUser?.uid;

    if (uid == null) return;

    await _firestore
        .collection("users")
        .doc(uid)
        .set(
      {
        "fcmToken": token,
        "platform": Platform.operatingSystem,
        "lastTokenUpdated": FieldValue.serverTimestamp(),
      },
      SetOptions(
        merge: true,
      ),
    );
  }
}