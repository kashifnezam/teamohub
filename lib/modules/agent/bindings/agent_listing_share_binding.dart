import 'package:get/get.dart';

import '../controllers/agent_listing_share_controller.dart';

class AgentListingShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => AgentListingShareController(),
    );
  }
}