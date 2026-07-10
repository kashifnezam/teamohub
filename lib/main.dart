import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/services/network_controller.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/*@pragma('vm:entry-point')
Future<void> firebaseBgHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  AppBootstrap.markDeliveredFromMessage(message);
}*/

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  FirebaseMessaging.onBackgroundMessage(firebaseBgHandler);
  await LocalNotificationService.init();
  await AppBootstrap.init();
  // Pass all uncaught "fatal" errors from the framework to Crashlytics

  if (!kIsWeb) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
  }
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NetworkController(), permanent: true);
    // Get.put(AuthController(), permanent: true);
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
    );
  }
}