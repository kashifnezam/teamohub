
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../widget/custom_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const MethodChannel _channel =
  MethodChannel('com.kashif.location_service');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    try {
      final user = "FirebaseAuth.instance.currentUser";

      /// 1️⃣ Not logged in → go login
      if (user != null) {
        Get.offAllNamed(Routes.login);
        return;
      }

      /// 2️⃣ Version check
     /* final updates = await FirebaseApi.getVersionUpdate();
      if (updates != null && (updates["expire"] ?? false)) {
        CustomAlert.errorAlert(
          "Please update your app to get latest features",
          title: "Update App",
        );
        return;
      }*/

      /// 3️⃣ Offline storage + device info
    /*  final offlineData = OfflineData();
      await offlineData.init();
      await DeviceInfo.getDetails();

      await offlineData.storeObject("uid", user.uid);
      await offlineData.refreshUserData(user.uid);*/

      /// 4️⃣ Mobile-only location checks
      /*if (!kIsWeb && userInfo?["role"] == null) {
        final locAlways = await Permission.locationAlways.isGranted;
        final gpsOn = await Geolocator.isLocationServiceEnabled();
        final bool consentAccepted =
            await offlineData.getBool("location_disclosure_accepted") ?? false;

        if (!consentAccepted || !locAlways || !gpsOn) {
          Get.offAllNamed(Routes.locationDisclosure);
          return;
        }

        try {
          await _channel.invokeMethod('startLocationUpdates');
        } on PlatformException catch (e) {
          AppConstants.log.e("Location service error: $e");
        }
      }*/

      /// 5️⃣ Refresh Firebase token
      // await FirebaseAuth.instance.currentUser?.getIdToken(true);

      /// 6️⃣ Navigate to root dashboard
      /// Middleware will handle role + platform
      if (!mounted) return;
      Get.offAllNamed(Routes.login);

      /// 7️⃣ Cleanup old records (non-blocking)
      // FirebaseTprApi.cleanupOldRecords(user.uid);
    } catch (e, s) {
      /*AppConstants.log.e("Splash init error: $e");
      AppConstants.log.e(s);*/
      Get.offAllNamed(Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image(
              height: 250,
              image: AssetImage("assets/logo/splash_logo.png"),
            ),
          ),
          CustomWidget.buildCircularProgressIndicator(),
          const SizedBox(height: 26),
        ],
      ),
    );
  }
}