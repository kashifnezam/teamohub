import 'package:get/get.dart';
import 'package:teamomarket/modules/favourite/controllers/favourite_controller.dart';
import 'package:teamomarket/modules/location/controllers/location_controller.dart';
import 'package:teamomarket/modules/my_ads/controllers/my_ads_controller.dart';
import 'package:teamomarket/modules/product/controllers/product_controller.dart';
import 'package:teamomarket/modules/product/controllers/product_search_controller.dart';
import 'package:teamomarket/modules/profile/controllers/profile_controller.dart';

import '../../chat/controllers/chat_controller.dart';
import '../controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<ChatController>(() => ChatController(), fenix: true);

    Get.lazyPut<ProfileController>(() => ProfileController());

    Get.lazyPut<MyAdsController>(() => MyAdsController());

    Get.lazyPut<LocationController>(() => LocationController());

    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);

    Get.lazyPut<ProductSearchController>(() => ProductSearchController(), fenix: true);

    Get.lazyPut<FavouriteController>(() => FavouriteController(), fenix: true);
  }
}