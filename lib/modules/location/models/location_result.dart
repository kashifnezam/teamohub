/*
class LocationResult {
  final String country;
  final String state;
  final String city;
  final String area;

  final double? latitude;
  final double? longitude;

  const LocationResult({
    required this.country,
    required this.state,
    required this.city,
    this.area = "",
    this.latitude,
    this.longitude,
  });

  String get fullAddress {
    return [
      area,
      city,
      state,
      country,
    ].where((e) => e.trim().isNotEmpty).join(", ");
  }
}*/

import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/state_model.dart';

class LocationResult {
  final CountryModel country;
  final StateModel state;
  final CityModel city;

  const LocationResult({
    required this.country,
    required this.state,
    required this.city,
  });

  String get displayName => '${city.name}, ${state.name}';

  Map<String, dynamic> toMap() {
    return {
      "country": country.toMap(),
      "state": state.toMap(),
      "city": city.toMap(),
    };
  }

  factory LocationResult.fromMap(
      Map<String, dynamic> map,
      ) {
    return LocationResult(
      country: CountryModel.fromMap(
        Map<String, dynamic>.from(map["country"]),
      ),
      state: StateModel.fromMap(
        Map<String, dynamic>.from(map["state"]),
      ),
      city: CityModel.fromMap(
        Map<String, dynamic>.from(map["city"]),
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is LocationResult &&
            other.country.name == country.name &&
            other.state.name == state.name &&
            other.city.name == city.name;
  }

  @override
  int get hashCode {
    return Object.hash(
      country.name,
      state.name,
      city.name,
    );
  }

  LocationResult copyWith({
    CountryModel? country,
    StateModel? state,
    CityModel? city,
  }) {
    return LocationResult(
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
    );
  }

  @override
  String toString() => displayName;
}