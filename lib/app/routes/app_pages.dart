import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:teamomarket/modules/home/bindings/dashboard_binding.dart';
import 'package:teamomarket/modules/home/views/dashboard_screen.dart';
import 'package:teamomarket/modules/my_ads/bindings/my_ads_binding.dart';
import 'package:teamomarket/modules/my_ads/views/my_ads_page.dart';
import 'package:teamomarket/modules/product/views/product_preview_page.dart';
import 'package:teamomarket/modules/profile/bindings/profile_binding.dart';
import 'package:teamomarket/modules/profile/views/profile_page.dart';
import '../../modules/auth/views/login_screen.dart';
import '../../modules/auth/views/signup_view.dart';
import '../../modules/banner/bindings/banner_binding.dart';
import '../../modules/banner/views/banner_form_page.dart';
import '../../modules/banner/views/banner_management_page.dart';
import '../../modules/category/bindings/category_binding.dart';
import '../../modules/category/views/categories_page.dart';
import '../../modules/category/views/sub_category_page.dart';
import '../../modules/chat/bindings/chat_binding.dart';
import '../../modules/chat/views/chat_list_page.dart';
import '../../modules/chat/views/chats_page.dart';
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
      binding: DashboardBinding(),
    ),


    GetPage(
      name: Routes.categories,
      page: () => const CategoriesPage(),
      binding: CategoryBinding(),
    ),

    GetPage(
      name: Routes.subCategories,
      page: () => SubCategoryPage(),
      binding: CategoryBinding(),
    ),
    //
    GetPage(
      name: Routes.addProduct,
      page: () => AddProductPage(),
    ),

    GetPage(
      name: Routes.productPreview,
      page: () => ProductPreviewPage(),
    ),

    GetPage(
      name: Routes.locationPicker,
      page: () => LocationPickerPage(),
      binding: LocationBinding(),
    ),

    GetPage(
      name: Routes.chats,
      page: () => const ChatListPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: Routes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),

    GetPage(
      name: Routes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: Routes.myAds,
      page: () => const MyAdsPage(),
      binding: MyAdsBinding(),
    ),

    GetPage(
      name: Routes.bannerManagement,
      page: () => const BannerManagementPage(),
      binding: BannerBinding(),
    ),

    GetPage(
      name: Routes.bannerForm,
      page: () => const BannerFormPage(),
      binding: BannerBinding(),
    ),
  ];
}
