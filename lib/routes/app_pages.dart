import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:teamomarket/pages/auth/login_screen.dart';
import '../pages/splashscreen.dart';
import 'app_routes.dart';
import 'middlewares/auth_guard.dart';
import 'middlewares/role_redirect_middleware.dart';

class AppPages {
  static final pages = [

    GetPage(
      name: Routes.appEntry,
      page: () => const SizedBox(),
      middlewares: [
        AuthGuard(),
        // RoleRedirectMiddleware(),
      ],
    ),

    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: Routes.login,
      page: () =>  AuthenticationView(),
    ),
   ];
}
