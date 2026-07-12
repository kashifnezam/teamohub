import 'dart:convert';

class CategoryFieldModel {
  final String id;

  /// Parent Category
  final String categoryId;

  /// Optional Sub Category
  final String? subCategoryId;

  /// Internal key
  /// Example:
  /// brand
  /// fuel
  /// year
  final String key;

  /// Label shown to the user
  final String label;

  /// text
  /// textarea
  /// number
  /// dropdown
  /// radio
  /// checkbox
  /// switch
  /// date
  /// image
  /// location
  final String type;

  /// Hint inside TextField
  final String? hint;

  /// Placeholder
  final String? placeholder;

  /// Default Value
  final dynamic defaultValue;

  /// Required?
  final bool isRequired;

  /// Hide / Show
  final bool isActive;

  /// Display Order
  final int order;

  /// Dropdown / Radio Options
  final List<String> options;

  /// Validation
  final int? minLength;
  final int? maxLength;

  final double? minValue;
  final double? maxValue;

  const CategoryFieldModel({
    required this.id,
    required this.categoryId,
    this.subCategoryId,
    required this.key,
    required this.label,
    required this.type,
    this.hint,
    this.placeholder,
    this.defaultValue,
    this.isRequired = false,
    this.isActive = true,
    this.order = 0,
    this.options = const [],
    this.minLength,
    this.maxLength,
    this.minValue,
    this.maxValue,
  });

  CategoryFieldModel copyWith({
    String? id,
    String? categoryId,
    String? subCategoryId,
    String? key,
    String? label,
    String? type,
    String? hint,
    String? placeholder,
    dynamic defaultValue,
    bool? isRequired,
    bool? isActive,
    int? order,
    List<String>? options,
    int? minLength,
    int? maxLength,
    double? minValue,
    double? maxValue,
  }) {
    return CategoryFieldModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      key: key ?? this.key,
      label: label ?? this.label,
      type: type ?? this.type,
      hint: hint ?? this.hint,
      placeholder: placeholder ?? this.placeholder,
      defaultValue: defaultValue ?? this.defaultValue,
      isRequired: isRequired ?? this.isRequired,
      isActive: isActive ?? this.isActive,
      order: order ?? this.order,
      options: options ?? this.options,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      minValue: minValue ?? this.minValue,
      maxValue: maxValue ?? this.maxValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'subCategoryId': subCategoryId,
      'key': key,
      'label': label,
      'type': type,
      'hint': hint,
      'placeholder': placeholder,
      'defaultValue': defaultValue,
      'isRequired': isRequired,
      'isActive': isActive,
      'order': order,
      'options': options,
      'minLength': minLength,
      'maxLength': maxLength,
      'minValue': minValue,
      'maxValue': maxValue,
    };
  }

  factory CategoryFieldModel.fromMap(Map<String, dynamic> map) {
    return CategoryFieldModel(
      id: map['id'] ?? '',
      categoryId: map['categoryId'] ?? '',
      subCategoryId: map['subCategoryId'],
      key: map['key'] ?? '',
      label: map['label'] ?? '',
      type: map['type'] ?? 'text',
      hint: map['hint'],
      placeholder: map['placeholder'],
      defaultValue: map['defaultValue'],
      isRequired: map['isRequired'] ?? false,
      isActive: map['isActive'] ?? true,
      order: map['order'] ?? 0,
      options: List<String>.from(map['options'] ?? const []),
      minLength: map['minLength'],
      maxLength: map['maxLength'],
      minValue: map['minValue']?.toDouble(),
      maxValue: map['maxValue']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryFieldModel.fromJson(String source) =>
      CategoryFieldModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryFieldModel(id: $id, key: $key)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryFieldModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}