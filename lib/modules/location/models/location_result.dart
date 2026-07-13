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
}