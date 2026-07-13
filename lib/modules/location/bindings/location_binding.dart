import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../repositories/location_repository.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationRepository>(
          () => LocationRepository(),
    );

    Get.lazyPut<LocationController>(
          () => LocationController(
        Get.find<LocationRepository>(),
      ),
    );
  }
}