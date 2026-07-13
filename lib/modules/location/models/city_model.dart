import 'dart:convert';

class CityModel {
  /// Unique City ID
  final String id;

  /// Parent Country
  final String countryId;

  /// Parent State
  final String stateId;

  /// City Name
  final String name;

  /// Display Order
  final int order;

  /// Active Status
  final bool isActive;

  /// Optional Coordinates
  /// (Useful later for maps, search radius, etc.)
  final double? latitude;
  final double? longitude;

  const CityModel({
    required this.id,
    required this.countryId,
    required this.stateId,
    required this.name,
    this.order = 0,
    this.isActive = true,
    this.latitude,
    this.longitude,
  });

  CityModel copyWith({
    String? id,
    String? countryId,
    String? stateId,
    String? name,
    int? order,
    bool? isActive,
    double? latitude,
    double? longitude,
  }) {
    return CityModel(
      id: id ?? this.id,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      name: name ?? this.name,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "countryId": countryId,
      "stateId": stateId,
      "name": name,
      "order": order,
      "isActive": isActive,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      id: map["id"] ?? "",
      countryId: map["countryId"] ?? "",
      stateId: map["stateId"] ?? "",
      name: map["name"] ?? "",
      order: map["order"] ?? 0,
      isActive: map["isActive"] ?? true,
      latitude: (map["latitude"] as num?)?.toDouble(),
      longitude: (map["longitude"] as num?)?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source));

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CityModel &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}