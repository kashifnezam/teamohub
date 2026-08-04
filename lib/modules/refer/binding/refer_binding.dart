import 'package:get/get.dart';
import 'package:teamomarket/modules/refer/controllers/refer_controller.dart';

class ReferBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
          () => ReferController(),
    );
  }
}