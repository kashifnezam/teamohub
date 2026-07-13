import 'dart:convert';

class StateModel {
  /// Unique State ID
  final String id;

  /// Parent Country ID
  final String countryId;

  /// State Name
  final String name;

  /// State Code
  /// Example:
  /// JH, BR, DL
  final String code;

  /// Display Order
  final int order;

  /// Active Status
  final bool isActive;

  const StateModel({
    required this.id,
    required this.countryId,
    required this.name,
    required this.code,
    this.order = 0,
    this.isActive = true,
  });

  StateModel copyWith({
    String? id,
    String? countryId,
    String? name,
    String? code,
    int? order,
    bool? isActive,
  }) {
    return StateModel(
      id: id ?? this.id,
      countryId: countryId ?? this.countryId,
      name: name ?? this.name,
      code: code ?? this.code,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "countryId": countryId,
      "name": name,
      "code": code,
      "order": order,
      "isActive": isActive,
    };
  }

  factory StateModel.fromMap(Map<String, dynamic> map) {
    return StateModel(
      id: map["id"] ?? "",
      countryId: map["countryId"] ?? "",
      name: map["name"] ?? "",
      code: map["code"] ?? "",
      order: map["order"] ?? 0,
      isActive: map["isActive"] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateModel.fromJson(String source) =>
      StateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StateModel &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}