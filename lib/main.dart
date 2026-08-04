import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/deep_link_service.dart';
import 'app/services/network_controller.dart';
import 'firebase_options.dart';
import 'modules/notification/bindings/notification_binding.dart';
import 'modules/notification/services/app_bootstrap.dart';
import 'modules/notification/services/local_notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // setPathUrlStrategy();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.init();
  await AppBootstrap.init();
  await DeepLinkService.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkController(), permanent: true);
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}