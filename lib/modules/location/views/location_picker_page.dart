import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/product/controllers/product_controller.dart';

import '../controllers/location_controller.dart';
import '../models/location_result.dart';
import '../widgets/area_text_field.dart';
import '../widgets/city_dropdown.dart';
import '../widgets/country_dropdown.dart';
import '../widgets/state_dropdown.dart';

class LocationPickerPage extends GetView<LocationController> {
   LocationPickerPage({super.key});
   final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Select Location",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: FilledButton(
          onPressed: () {
            if (!controller.isLocationSelected) {
              Get.snackbar(
                "Location Required",
                "Please select Country, State and City.",
              );
              return;
            }

            Get.back(
              result: LocationResult(
                country: controller.selectedCountry.value!.name,
                state: controller.selectedState.value!.name,
                city: controller.selectedCity.value!.name,
                area: controller.areaController.text.trim(),
              ),
            );
          },
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(56),
          ),
          child: const Text(
            "Save Location",
          ),
        ),
      ),

      body:  ListView(
          padding: const EdgeInsets.all(18),
          children: [

            //--------------------------------------------------
            // Header
            //--------------------------------------------------

            Text(
              "Where is your product located?",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "This helps nearby buyers discover your listing.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 28),

            //--------------------------------------------------
            // Country
            //--------------------------------------------------

            const CountryDropdown(),

            const SizedBox(height: 18),

            //--------------------------------------------------
            // State
            //--------------------------------------------------

            const StateDropdown(),

            const SizedBox(height: 18),

            //--------------------------------------------------
            // City
            //--------------------------------------------------

            const CityDropdown(),

            const SizedBox(height: 18),

            //--------------------------------------------------
            // Area
            //--------------------------------------------------

            const AreaTextField(),

            const SizedBox(height: 24),

            //--------------------------------------------------
            // GPS
            //--------------------------------------------------

            OutlinedButton.icon(
              onPressed: productController.useCurrentLocation,
              icon: const Icon(
                Icons.my_location,
              ),
              label: const Text(
                "Use Current Location",
              ),
            ),

            const SizedBox(height: 18),

            Text(
              "Your exact address is never shown publicly.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      );
  }
}