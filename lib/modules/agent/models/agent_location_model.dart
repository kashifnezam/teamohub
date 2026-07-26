import '../../location/models/city_model.dart';
import '../../location/models/state_model.dart';

class AgentLocationModel {
  final StateModel state;
  final List<CityModel> cities;

  const AgentLocationModel({
    required this.state,
    this.cities = const [],
  });

  AgentLocationModel copyWith({
    StateModel? state,
    List<CityModel>? cities,
  }) {
    return AgentLocationModel(
      state: state ?? this.state,
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "state": state.toMap(),
      "cities": cities.map((e) => e.toMap()).toList(),
    };
  }

  factory AgentLocationModel.fromMap(
      Map<String, dynamic> map,
      ) {
    return AgentLocationModel(
      state: StateModel.fromMap(
        Map<String, dynamic>.from(map["state"]),
      ),
      cities: (map["cities"] as List<dynamic>? ?? [])
          .map(
            (e) => CityModel.fromMap(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList(),
    );
  }
}