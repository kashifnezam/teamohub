import 'package:get/get.dart';

import '../controllers/agent_my_listings_controller.dart';

class AgentMyListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => AgentMyListingsController(),
    );
  }
}