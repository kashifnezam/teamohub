import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

      final offlineData = OfflineData();
      await offlineData.init();
      await DeviceInfo.getDetails();

      if (user != null) {
        await offlineData.storeObject("id", user.uid);
        await offlineData.refreshUserData(user.uid);
        await user.getIdToken(true);
      }

      if (!mounted) return;

      Get.offAllNamed(Routes.dashboard);
    } catch (_) {
      Get.offAllNamed(Routes.dashboard);
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