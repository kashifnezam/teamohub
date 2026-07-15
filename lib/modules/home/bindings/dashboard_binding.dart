import 'package:get/get.dart';

import '../../chat/controllers/chat_controller.dart';
import '../controllers/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    Get.lazyPut<ChatController>(() => ChatController());
    //
    // Get.lazyPut<AccountController>(() => AccountController());
  }
}