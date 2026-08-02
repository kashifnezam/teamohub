import 'package:get_storage/get_storage.dart';

import '../models/location_result.dart';

class CurrentLocationService {
  CurrentLocationService._();

  static final CurrentLocationService instance =
  CurrentLocationService._();

  static const _key = "current_location";

  final GetStorage _box = GetStorage();

  LocationResult? get() {
    final data = _box.read<Map<String, dynamic>>(_key);

    if (data == null) return null;

    return LocationResult.fromMap(data);
  }

  Future<void> save(LocationResult location) async {
    await _box.write(_key, location.toMap());
  }

  Future<void> clear() async {
    await _box.remove(_key);
  }
}