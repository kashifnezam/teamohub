import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/services/location_api_service.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/location_result.dart';
import '../models/state_model.dart';
import '../repositories/location_repository.dart';
import '../services/recent_location_service.dart';

class LocationController extends GetxController {
  final TextEditingController areaController = TextEditingController();
  LocationController();

  //----------------------------------------------------------
  // Loading
  //----------------------------------------------------------

  final RxBool isCountryLoading = false.obs;
  final RxBool isStateLoading = false.obs;
  final RxBool isCityLoading = false.obs;

  //----------------------------------------------------------
  // Lists
  //----------------------------------------------------------

  final RxList<CountryModel> countries = <CountryModel>[].obs;
  final RxList<StateModel> states = <StateModel>[].obs;
  final RxList<CityModel> cities = <CityModel>[].obs;

  //----------------------------------------------------------
// Filtered Lists
//----------------------------------------------------------

  final RxList<StateModel> filteredStates = <StateModel>[].obs;
  final RxList<CityModel> filteredCities = <CityModel>[].obs;

//----------------------------------------------------------
// Recent Locations
//----------------------------------------------------------

  final RxList<LocationResult> recentLocations = <LocationResult>[].obs;

//----------------------------------------------------------
// Search
//----------------------------------------------------------

  final RxBool stateSearching = false.obs;
  final RxBool citySearching = false.obs;

  final TextEditingController stateSearchController = TextEditingController();
  final TextEditingController districtSearchController = TextEditingController();

//----------------------------------------------------------
// Loading
//----------------------------------------------------------

  final RxBool loadingStates = false.obs;
  final RxBool loadingCities = false.obs;

//----------------------------------------------------------
// City Cache
//----------------------------------------------------------

  final Map<String, List<CityModel>> _cityCache = {};

//----------------------------------------------------------
// Recent Service
//----------------------------------------------------------

  final RecentLocationService _recentService = RecentLocationService.instance;

  //----------------------------------------------------------
  // Selected
  //----------------------------------------------------------

  final Rxn<CountryModel> selectedCountry = Rxn<CountryModel>();
  final Rxn<StateModel> selectedState = Rxn<StateModel>();
  final Rxn<CityModel> selectedCity = Rxn<CityModel>();

  //----------------------------------------------------------
  // Area
  //----------------------------------------------------------

  final RxString area = "".obs;

  final LocationApiService _service = LocationApiService();

  @override
  void onInit() {
    super.onInit();
    selectedCountry.value = CountryModel(id: "in", name: "India", code: "123", phoneCode: "-", flag: "ind");
    loadStates("India");
    loadRecent();
  }

  bool get hasRecentLocations => recentLocations.isNotEmpty;
  bool get hasStates => filteredStates.isNotEmpty;
  bool get hasCities => filteredCities.isNotEmpty;
  bool get isSearching => stateSearching.value || citySearching.value;

  Future<void> saveRecent(
      LocationResult result,
      ) async {
    
    await _recentService.saveRecent(result);

    loadRecent();
  }

  void loadRecent() {
    recentLocations.assignAll(
      _recentService.getRecent(),
    );
  }

  //----------------------------------------------------------
  // Filter States
  //----------------------------------------------------------

  void filterStates(String keyword) {
    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      stateSearching.value = false;
      filteredStates.assignAll(states);
      return;
    }

    stateSearching.value = true;

    filteredStates.assignAll(
      states.where(
            (state) => state.name.toLowerCase().contains(query),
      ),
    );
  }

  //----------------------------------------------------------
// Filter Cities
//----------------------------------------------------------

  void filterCities(String keyword) {
    final query = keyword.trim().toLowerCase();

    if (query.isEmpty) {
      citySearching.value = false;
      filteredCities.assignAll(cities);
      return;
    }

    citySearching.value = true;

    filteredCities.assignAll(
      cities.where(
            (city) => city.name.toLowerCase().contains(query),
      ),
    );
  }

  //----------------------------------------------------------
  // Countries
  //----------------------------------------------------------

  Future<void> loadCountries() async {
    try {
      final result = await _service.getCountries();

      countries.assignAll(result);

      if (countries.isNotEmpty) {
        selectedCountry.value = null;
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "Failed to load countries",
      );
    }
  }

  //----------------------------------------------------------
  // States
  //----------------------------------------------------------

  Future<void> loadStates(
      String country,
      ) async {

    try {
      loadingStates.value = true;
      final result = await _service.getStates(country);

      states.assignAll(result);
      filteredStates.assignAll(result);

      loadingStates.value = false;

    } catch (e) {
      loadingStates.value = false;
      Get.snackbar(
        "Error",
        "Unable to load states.",
      );

    }

  }

  //----------------------------------------------------------
  // Cities
  //----------------------------------------------------------

  Future<void> loadCities(
      String country,
      String state,
      ) async {

    final cacheKey = "$country-$state";
    loadingCities.value = true;
    if (_cityCache.containsKey(cacheKey)) {
      cities.assignAll(_cityCache[cacheKey]!);
      filteredCities.assignAll(_cityCache[cacheKey]!);
      loadingCities.value = false;
      return;
    }

    try {

      final result = await _service.getCities(
        country,
        state,
      );

      _cityCache[cacheKey] = result;

      cities.assignAll(result);
      filteredCities.assignAll(result);

    } catch (e) {

      Get.snackbar(
        "Error",
        "Unable to load cities.",
      );

    } finally {

      loadingCities.value = false;

    }
  }

  //----------------------------------------------------------
  // Country Selected
  //----------------------------------------------------------

  Future<void> selectCountry(
      CountryModel country,
      ) async {
    selectedCountry.value = country;

    selectedState.value = null;
    selectedCity.value = null;

    states.clear();
    cities.clear();

    await loadStates(country.name);

    if (states.isNotEmpty) {
      await selectState(
        states.first,
      );
    }
  }

  //----------------------------------------------------------
  // State Selected
  //----------------------------------------------------------

  Future<void> selectState( StateModel state) async {
    loadingCities.value = true;

    selectedState.value = state;
    selectedCity.value = null;

    final cacheKey = "${selectedCountry.value!.name}-${state.name}";

    if (_cityCache.containsKey(cacheKey)) {

      cities.assignAll(_cityCache[cacheKey]!);
      filteredCities.assignAll(_cityCache[cacheKey]!);
      loadingCities.value = false;
      return;
    }

    await loadCities(
      selectedCountry.value!.name,
      state.name,
    );
  }

  //----------------------------------------------------------
  // City Selected
  //----------------------------------------------------------

  void selectCity(
      CityModel city,
      ) {
    selectedCity.value = city;
  }

  //----------------------------------------------------------
  // Area
  //----------------------------------------------------------

  void setArea(String value) {
    area.value = value;
  }

  //----------------------------------------------------------
  // Helpers
  //----------------------------------------------------------

  String get fullAddress {
    return [
      area.value,
      selectedCity.value?.name,
      selectedState.value?.name,
      selectedCountry.value?.name,
    ]
        .where(
          (e) =>
      e != null &&
          e.toString().trim().isNotEmpty,
    )
        .join(", ");
  }

  bool get isLocationSelected {
    return selectedCountry.value != null &&
        selectedState.value != null &&
        selectedCity.value != null;
  }

  //----------------------------------------------------------
// Current Result
//----------------------------------------------------------

  LocationResult? getLocationResult() {

    if (!isLocationSelected) {
      return null;
    }

    return LocationResult(
      country: selectedCountry.value!,
      state: selectedState.value!,
      city: selectedCity.value!,
    );

  }


  //----------------------------------------------------------
  // Reset
  //----------------------------------------------------------

  void clearStateSearch() {
    stateSearchController.clear();

    filteredStates.assignAll(states);

    stateSearching.value = false;
  }
  void clearCitySearch() {
    districtSearchController.clear();

    filteredCities.assignAll(cities);

    citySearching.value = false;
  }

  void clearSearch() {

    stateSearchController.clear();
    districtSearchController.clear();

    filteredStates.assignAll(states);
    filteredCities.assignAll(cities);

    citySearching.value = false;
    stateSearching.value = false;

  }

  //----------------------------------------------------------
  // Remove Recent
  //----------------------------------------------------------

  Future<void> removeRecent(
      LocationResult location,
      ) async {

    await _recentService.remove(location);

    loadRecent();
  }

  //----------------------------------------------------------
  // Clear Recent
  //----------------------------------------------------------

  Future<void> clearRecent() async {

    await _recentService.clear();

    recentLocations.clear();

  }
//----------------------------------------------------------
// Reset
//----------------------------------------------------------

  void clear() {

    selectedCountry.value = null;
    selectedState.value = null;
    selectedCity.value = null;

    countries.clear();
    states.clear();
    cities.clear();

    filteredStates.clear();
    filteredCities.clear();

    stateSearchController.clear();
    districtSearchController.clear();

    stateSearching.value = false;
    citySearching.value = false;
    area.value = "";

  }
}