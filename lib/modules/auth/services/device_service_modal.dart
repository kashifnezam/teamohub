import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../../../app/services/device_info.dart';

class DeviceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateDeviceInfo(String userId) async {
    await DeviceInfo.getDetails();
    final Map<String, dynamic> data = {
      'lastLogin': FieldValue.serverTimestamp(),
    };

    if (DeviceInfo.deviceId != null) {
      data['deviceId'] = DeviceInfo.deviceId;
    }

    if (DeviceInfo.macAddress != null) {
      data['macAd'] = DeviceInfo.macAddress;
    }

    if (DeviceInfo.ipAddress != null) {
      data['ipAddress'] = DeviceInfo.ipAddress;
    }

    /// 🔔 FCM
    try {
      if (!kIsWeb) {
        final String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) data['fcmToken'] = fcmToken;
      } else {
        await FirebaseMessaging.instance.requestPermission();

        final token = await FirebaseMessaging.instance.getToken(
          vapidKey: null, // optional if configured
        );

        if (token != null) data['fcmTokenWeb'] = token;
      }
    } catch (_) {}

    await _firestore.collection('users').doc(userId).set(
      data,
      SetOptions(merge: true),
    );
  }
}