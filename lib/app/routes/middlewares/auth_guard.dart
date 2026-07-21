import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_alert.dart';
import '../app_routes.dart';

class AuthGuard extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {

    if (FirebaseAuth.instance.currentUser != null) {
      return null;
    }

    Future.delayed(Duration.zero, () {
      CustomAlert.infoAlert(
        "Please login to continue.",
        title: "Login Required",
      );
    });

    return const RouteSettings(
      name: Routes.login,
    );
  }
}