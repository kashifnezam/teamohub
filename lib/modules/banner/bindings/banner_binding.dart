import 'package:get/get.dart';
import 'package:teamomarket/modules/banner/controllers/banner_management_controller.dart';

import '../controllers/banner_controller.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerController>(
          () => BannerController(),
    );
    Get.lazyPut<BannerManagementController>(
          () => BannerManagementController(),
    );
  }
}