import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product/controllers/product_controller.dart';
import '../controllers/location_controller.dart';
import '../models/country_model.dart';
import '../models/location_result.dart';
import '../models/state_model.dart';
import '../models/city_model.dart';
import '../widgets/search_box.dart';
import '../widgets/loading_location.dart';
import '../widgets/empty_location.dart';
import '../widgets/location_tile.dart';

class DistrictListPage extends StatelessWidget {
  DistrictListPage({
    super.key,
    required this.country,
    required this.state,
  });

  final CountryModel country;
  final StateModel state;
  final LocationController controller = Get.find<LocationController>();
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(state.name),
      ),

      body: Column(
        children: [

          SearchBox(
            controller: controller.districtSearchController,
            hintText: "Search district",
            onChanged: controller.filterCities,
            onClear: controller.clearCitySearch,
          ),

          Expanded(
            child: Obx(
                  () => AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 250,
                ),
                transitionBuilder:
                    (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: _buildBody(),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildBody() {
    if (controller.loadingCities.value) {
      return const LoadingLocation();
    }

    if (!controller.hasCities) {
      return const EmptyLocation();
    }

    return ListView.separated(

      key: const ValueKey("districts"),

      itemCount: controller.filteredCities.length,

      separatorBuilder: (_, __) =>
      const Divider(height: 1),

      itemBuilder: (_, index) {
        final CityModel city =
        controller.filteredCities[index];

        return LocationTile(
          title: city.name,
          icon: Icons.location_city_outlined,
          showChevron: false,
          onTap: () => _selectCity(city),
        );
      },
    );
  }

  //----------------------------------------------------------
// Select City
//----------------------------------------------------------

  Future<void> _selectCity(
      CityModel city,
      ) async {

    controller.selectedCountry.value = country;
    controller.selectedState.value = state;
    controller.selectedCity.value = city;

    final location = LocationResult(
      country: country,
      state: state,
      city: city,
    );

    await controller.saveRecent(location);

    productController.setLocation(
      countryValue: country.name,
      stateValue: state.name,
      cityValue: city.name,
      latitudeValue: city.latitude,
      longitudeValue: city.longitude,
    );

    Get.back(
      result: location,
    );
  }
}