  import 'dart:convert';

  class CountryModel {
    final String id;
    final String name;
    final String code;
    final String phoneCode;
    final String flag;

    final bool isActive;
    final int order;

    const CountryModel({
      required this.id,
      required this.name,
      required this.code,
      required this.phoneCode,
      required this.flag,
      this.isActive = true,
      this.order = 0,
    });

    CountryModel copyWith({
      String? id,
      String? name,
      String? code,
      String? phoneCode,
      String? flag,
      bool? isActive,
      int? order,
    }) {
      return CountryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        phoneCode: phoneCode ?? this.phoneCode,
        flag: flag ?? this.flag,
        isActive: isActive ?? this.isActive,
        order: order ?? this.order,
      );
    }

    Map<String, dynamic> toMap() {
      return {
        "id": id,
        "name": name,
        "code": code,
        "phoneCode": phoneCode,
        "flag": flag,
        "isActive": isActive,
        "order": order,
      };
    }

    factory CountryModel.fromMap(Map<String, dynamic> map) {
      return CountryModel(
        id: map["id"] ?? "",
        name: map["name"] ?? "",
        code: map["code"] ?? "",
        phoneCode: map["phoneCode"] ?? "",
        flag: map["flag"] ?? "",
        isActive: map["isActive"] ?? true,
        order: map["order"] ?? 0,
      );
    }

    String toJson() => json.encode(toMap());

    factory CountryModel.fromJson(String source) =>
        CountryModel.fromMap(json.decode(source));

    @override
    String toString() {
      return "$flag $name";
    }

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
            other is CountryModel && other.id == id;

    @override
    int get hashCode => id.hashCode;
  }