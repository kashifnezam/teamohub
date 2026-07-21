import 'package:get/get.dart';
import 'package:teamomarket/modules/my_ads/controllers/my_ads_controller.dart';
import 'package:teamomarket/modules/profile/controllers/profile_controller.dart';

import '../../chat/controllers/chat_controller.dart';
import '../controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<ChatController>(() => ChatController());

    Get.lazyPut<ProfileController>(() => ProfileController());

    Get.lazyPut<MyAdsController>(() => MyAdsController());
  }
}