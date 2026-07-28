import 'package:get/get.dart';

import '../repository/notification_repository.dart';

class NotificationController
    extends GetxController {
  @override
  void onInit() {
    super.onInit();

    NotificationRepository.instance.initialize();
  }
}