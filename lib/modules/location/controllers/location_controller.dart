import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../app/services/location_api_service.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/state_model.dart';
import '../repositories/location_repository.dart';

class LocationController extends GetxController {
  final LocationRepository _repository;
  final TextEditingController areaController = TextEditingController();
  LocationController(this._repository);

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
    loadCountries();
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

      final result = await _service.getStates(country);

      states.assignAll(result);

    } catch (e) {

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

    try {

      final result =
      await _service.getCities(
        country,
        state,
      );

      cities.assignAll(result);

    } catch (e) {
print(e);
      Get.snackbar(
        "Error",
        "Unable to load cities.",
      );

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

  Future<void> selectState(
      StateModel state,
      ) async {
    selectedState.value = state;

    selectedCity.value = null;

    cities.clear();

    await loadCities(selectedCountry.value!.name, state.name);

    if (cities.isNotEmpty) {
      selectCity(
        cities.first,
      );
    }
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
  // Reset
  //----------------------------------------------------------

  void clear() {
    selectedCountry.value = null;
    selectedState.value = null;
    selectedCity.value = null;

    countries.clear();
    states.clear();
    cities.clear();

    area.value = "";
  }

  @override
  void onClose() {
    areaController.dispose();
    super.onClose();
  }
}