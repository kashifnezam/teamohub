import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';
import 'package:teamomarket/modules/location/controllers/location_controller.dart';

class LocationBottomSheet extends StatelessWidget {
  final VoidCallback? onUseCurrentLocation;
  final VoidCallback ?onSearchManually;
  final LocationController locationController = Get.find<LocationController>();
  LocationBottomSheet({
    super.key,
     this.onUseCurrentLocation,
     this.onSearchManually,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Obx(() {
            return ElevatedButton.icon(
              onPressed: locationController.handleLocationButton,
              icon: Icon(locationController.buttonIcon),
              label: Text(locationController.buttonText),
              );
            }),

                  const SizedBox(height: 12),

            Text(
              "Find nearby products, trusted sellers\nand the best deals around you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () => Get.toNamed(Routes.locationPicker),
                icon: const Icon(Icons.search),
                label: const Text(
                  "Search city manually",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}