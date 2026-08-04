import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../product/controllers/product_controller.dart';
import '../controllers/location_controller.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/location_result.dart';
import '../models/state_model.dart';
import '../widgets/current_location_tile.dart';
import '../widgets/empty_location.dart';
import '../widgets/loading_location.dart';
import '../widgets/location_tile.dart';
import '../widgets/recent_section.dart';
import '../widgets/search_box.dart';
import '../widgets/section_header.dart';
import 'district_list_page.dart';

class LocationPickerPage extends StatelessWidget {
  LocationPickerPage({super.key});

  final LocationController controller = Get.put(LocationController());

  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Select Location",
        ),
      ),

      body: Column(
        children: [

          SearchBox(
            controller:
            controller.stateSearchController,
            hintText: "Search state",
            onChanged: controller.filterStates,
            onClear: controller.clearStateSearch,
          ),

          Expanded(
            child: Obx(
                  () =>
                  AnimatedSwitcher(
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
    if (controller.loadingStates.value) {
      return const LoadingLocation();
    }

    if (!controller.hasStates) {
      return const EmptyLocation();
    }

    return ListView(
      key: const ValueKey("state_list"),

      children: [

        CurrentLocationTile(
          onTap: () async {

            final result = await controller.handleLocationButton();

            if (result == null) return;

            productController.setLocation(
              countryValue: result.country.name,
              stateValue: result.state.name,
              cityValue: result.city.name,
              latitudeValue: result.city.latitude ?? 0,
              longitudeValue: result.city.longitude ?? 0,
            );

            Get.back(result: result);
          },
        ),
        LocationTile(
          title: "All India",
          icon: Icons.public,
          onTap: () async {
            const location = LocationResult(
              country: CountryModel(
                id: "in",
                name: "India",
                code: "91",
                phoneCode: "+91",
                flag: "",
              ),
              state: StateModel(
                id: "",
                name: "India", countryId: '', code: '',
              ),
              city: CityModel(
                id: "",
                name: "All in India", countryId: '', stateId: '',
              ),
            );

            await controller.saveRecent(location);

            productController.setLocation(
              countryValue: "India",
              stateValue: "",
              cityValue: "",
            );

            Get.back(result: location);
          },
        ),

        const Divider(height: 1),

        if (controller.recentLocations.isNotEmpty)

          RecentSection(
            locations: controller.recentLocations,
            onTap: _onRecentTap,
          ),

        const SectionHeader(
          title: "States",
        ),

        ...controller.filteredStates.map(
          _buildStateTile,
        ),

      ],
    );
  }

  Widget _buildStateTile(StateModel state,) {
    return LocationTile(
      title: state.name,
      icon: Icons.location_on_outlined,
      showChevron: true,
      onTap: () => _openDistrictPage(state),
    );
  }

  //----------------------------------------------------------
// Recent Location
//----------------------------------------------------------

  Future<void> _onRecentTap(LocationResult location) async {
    await controller.saveRecent(location);

    controller.selectedCountry.value = location.country;
    controller.selectedState.value = location.state;
    controller.selectedCity.value = location.city;

    productController.setLocation(
      countryValue: location.country.name,
      stateValue: location.state.name,
      cityValue: location.city.name,
      latitudeValue: location.city.latitude ?? 0,
      longitudeValue: location.city.longitude ?? 0,
    );

    Get.back(result: location);
  }

  //----------------------------------------------------------
// Open District Page
//----------------------------------------------------------

  Future<void> _openDistrictPage(
      StateModel state,
      ) async {

    controller.selectState(state);

    final LocationResult? result = await Get.to<LocationResult>(
          () => DistrictListPage(
        country: controller.selectedCountry.value!,
        state: state,
      ),
    );

    if (result != null) {
      Get.back(result: result);
    }
  }
}

