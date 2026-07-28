import 'package:get/get.dart';

import '../controllers/agent_directory_controller.dart';

class AgentDirectoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => AgentDirectoryController(),
    );
  }
}