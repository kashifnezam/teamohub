import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/services/device_info.dart';
import '../../../app/utils/offline_data.dart';
import '../../../app/widgets/custom_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      /// 1️⃣ Version check
      // final updates = await FirebaseApi.getVersionUpdate();
      //
      // if (updates != null && (updates["expire"] ?? false)) {
      //   CustomAlert.errorAlert(
      //     "Please update your app to get the latest features.",
      //     title: "Update App",
      //   );
      //   return;
      // }

      /// 2️⃣ Offline storage + device info
      final offlineData = OfflineData();
      await offlineData.init();
      await DeviceInfo.getDetails();

      /// 3️⃣ Not logged in
      if (user == null) {
        Get.offAllNamed(Routes.login);
        return;
      }

      /// 4️⃣ Store user id
      await offlineData.storeObject("id", user.uid);
      await offlineData.refreshUserData(user.uid);

      AppConstants.log.i(await offlineData.getUserDetails());
      /// 5️⃣ Refresh Firebase token
      await user.getIdToken(true);

      if (!mounted) return;

      /// 6️⃣ Navigate to app
      Get.offAllNamed(Routes.appEntry);
    } catch (e, s) {
      debugPrint("Splash Error: $e");
      debugPrintStack(stackTrace: s);
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Image(
                image: AssetImage(
                  "assets/logo/splash_logo.png",
                ),
                height: 260,
              ),
            ),
          ),
          CustomWidget.buildCircularProgressIndicator(),
          const SizedBox(height: 26),
        ],
      ),
    );
  }
}