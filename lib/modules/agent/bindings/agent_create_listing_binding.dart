import 'package:get/get.dart';

import '../controllers/agent_create_listing_controller.dart';

class AgentCreateListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AgentCreateListingController>(
          () => AgentCreateListingController(),
    );
  }
}