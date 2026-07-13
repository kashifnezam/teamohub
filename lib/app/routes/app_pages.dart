import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:teamomarket/modules/home/views/dashboard_screen.dart';
import 'package:teamomarket/modules/product/views/product_preview_page.dart';
import '../../modules/auth/views/login_screen.dart';
import '../../modules/auth/views/signup_view.dart';
import '../../modules/category/bindings/category_binding.dart';
import '../../modules/category/views/categories_page.dart';
import '../../modules/category/views/sub_category_page.dart';
import '../../modules/location/bindings/location_binding.dart';
import '../../modules/location/views/location_picker_page.dart';
import '../../modules/product/views/add_product_page.dart';
import '../../modules/splash/views/splashscreen.dart';
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
        RoleRedirectMiddleware(),
      ],
    ),

    GetPage(
      name: Routes.signup,
      page: () =>  SignupView(),
    ),

    GetPage(
      name: Routes.login,
      page: () =>  AuthenticationView(),
    ),


    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),


    GetPage(
      name: Routes.dashboard,
      page: () =>  DashboardScreen(),
    ),


    GetPage(
      name: Routes.categories,
      page: () => const CategoriesPage(),
      binding: CategoryBinding(),
    ),

    GetPage(
      name: Routes.subCategories,
      page: () => const SubCategoryPage(),
    ),
    //
    GetPage(
      name: Routes.addProduct,
      page: () => AddProductPage(),
      // binding: ProductBinding(),
    ),

    GetPage(
      name: Routes.productPreview,
      page: () => ProductPreviewPage(),
      // binding: ProductBinding(),
    ),

    GetPage(
      name: Routes.locationPicker,
      page: () => LocationPickerPage(),
      binding: LocationBinding(),
    ),
  ];
}
