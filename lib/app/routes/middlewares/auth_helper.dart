import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils/custom_alert.dart';
import '../app_routes.dart';

class AuthHelper {
  AuthHelper._();

  static bool get isLoggedIn =>
      FirebaseAuth.instance.currentUser != null;

  static Future<bool> requireLogin({
    String message = "Please login to continue.",
  }) async {
    if (isLoggedIn) return true;

    final login = await CustomAlert.confirmAlert(
      message,
      title: "Login Required",
      confirmText: "Login",
      cancelText: "Cancel",
    );

    if (login == true) {
      Get.toNamed(Routes.login);
    }

    return false;
  }
}