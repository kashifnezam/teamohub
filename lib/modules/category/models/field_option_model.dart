import 'dart:convert';

class FieldOption {
  final String id;
  final String label;

  const FieldOption({
    required this.id,
    required this.label,
  });

  factory FieldOption.fromMap(Map<String, dynamic> map) {
    return FieldOption(
      id: map['id'] ?? '',
      label: map['label'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
    };
  }

  factory FieldOption.fromJson(String source) =>
      FieldOption.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FieldOption &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}