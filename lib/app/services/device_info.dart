import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import '../utils/location_utils.dart';

class DeviceInfo {
  static String? macAddress;
  static String? ipAddress;
  static String? deviceId;
  static String? userUID;

  static Future<void> getDetails() async {
    try {
      if (!kIsWeb) {
        macAddress = await LocationUtils.getMacAddress();
        ipAddress = await LocationUtils.getLocalIPAddress();
        deviceId = await LocationUtils.getDeviceId();
      } else {
        /// Web fallback
        macAddress = null;
        ipAddress = null;
        deviceId = "web-${DateTime.now().millisecondsSinceEpoch}";
      }

      userUID = FirebaseAuth.instance.currentUser?.uid;

      AppConstants.log.i('Device ID: $deviceId');
      AppConstants.log.i('User UID: $userUID');
    } catch (e) {
      AppConstants.log.e('Error in getDetails: $e');
    }
  }
}