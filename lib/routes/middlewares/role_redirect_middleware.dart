// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../service/auth_service_modal.dart';
// import '../../../../utils/custom_alert.dart';
// import '../../../../utils/offline_data.dart';
// import '../app_routes.dart';
//
// class RoleRedirectMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     final role = userInfo?["role"];
//
//     /// No role → family home
//     if (role == null) {
//       return const RouteSettings(name: Routes.familyHome);
//     }
//
//     /// Executive
//     if (role == "field_executive") {
//
//       /// Executive on web → logout
//       if (kIsWeb) {
//         Future.microtask(() async {
//           await AuthService.logout();
//
//           CustomAlert.errorAlert(
//             "Executives must login from the mobile app.",
//             title: "Access Restricted",
//           );
//         });
//
//         return const RouteSettings(name: Routes.login);
//       }
//
//       return const RouteSettings(name: Routes.executiveDashboard);
//     }
//
//     /// Manager
//     if (role == "root_manager") {
//       return const RouteSettings(name: Routes.managerDashboard);
//     }
//
//     /// fallback
//     return const RouteSettings(name: Routes.familyHome);
//   }
// }