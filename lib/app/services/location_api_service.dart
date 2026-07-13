import '../../modules/location/models/city_model.dart';
import '../../modules/location/models/country_model.dart';
import '../../modules/location/models/state_model.dart';
import '../api/api_client.dart';
import '../api/api_endpoints.dart';


class LocationApiService {
  final ApiClient _apiClient = ApiClient();

  ///------------------------------------------
  /// Get Countries
  ///------------------------------------------
  Future<List<CountryModel>> getCountries() async {
    final result = await _apiClient.get(ApiEndpoints.countries);
    print(result);

    final List<CountryModel> countries =
    (result["data"] as List)
        .map(
          (e) => CountryModel(
        id:  e["iso3"]?.toString() ?? "",
        name: e["country"]?.toString() ?? "",
        code: e["iso3"]?.toString() ?? "",
        phoneCode: "", // Not available in the API response
        flag: e["iso2"]?.toString().toLowerCase() ?? "", // Optional: use iso2 if you build flag URLs
      ),
    )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    return countries;
  }

  ///------------------------------------------
  /// Get States
  ///------------------------------------------
  Future<List<StateModel>> getStates(String country) async {
    final response = await _apiClient.get(
      "${ApiEndpoints.states}?country=${Uri.encodeQueryComponent(country)}",
    );

    final List states = response["data"]["states"] as List;

    return states
        .map(
          (e) => StateModel(
        id: e["state_code"],
        countryId: "",
        code: e["state_code"] ?? "",
        name: e["name"] ?? "",
      ),
    )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  ///------------------------------------------
  /// Get Cities
  ///------------------------------------------
  Future<List<CityModel>> getCities(
      String country,
      String state,
      ) async {
    print(country);
    print(state);
    final response = await _apiClient.get(
      "${ApiEndpoints.cities}"
          "?country=${Uri.encodeQueryComponent(country)}"
          "&state=${Uri.encodeQueryComponent(state)}",
    );

    final List cities = response["data"] as List;

    return cities
        .map(
          (e) => CityModel(
        id: e.toString(),
        countryId: "",
        stateId: "",
        name: e.toString(),
      ),
    )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}