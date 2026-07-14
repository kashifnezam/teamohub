import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../repositories/location_repository.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationRepository>(
          () => LocationRepository(),
      fenix: true,
    );

    Get.lazyPut<LocationController>(
          () => LocationController(
      ),
      fenix: true,
    );
  }
}