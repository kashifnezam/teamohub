import 'package:get_storage/get_storage.dart';

import '../models/location_result.dart';

class RecentLocationService {
  RecentLocationService._();

  static final RecentLocationService instance =
  RecentLocationService._();

  static const String _storageKey = 'recent_locations';

  final GetStorage _box = GetStorage();

  /// Returns recently used locations.
  List<LocationResult> getRecent() {
    final List<dynamic>? data = _box.read<List<dynamic>>(_storageKey);

    if (data == null || data.isEmpty) {
      return [];
    }

    return data
        .map(
          (e) => LocationResult.fromMap(
        Map<String, dynamic>.from(e),
      ),
    )
        .toList();
  }

  /// Save a location.
  ///
  /// • Moves duplicate to top
  /// • Keeps maximum 5 items
  Future<void> saveRecent(LocationResult location) async {
    final recent = getRecent();

    recent.removeWhere((item) => item == location);

    recent.insert(0, location);

    if (recent.length > 5) {
      recent.removeRange(5, recent.length);
    }

    await _box.write(
      _storageKey,
      recent.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> remove(LocationResult location) async {
    final recent = getRecent();

    recent.removeWhere((item) => item == location);

    await _box.write(
      _storageKey,
      recent.map((e) => e.toMap()).toList(),
    );
  }

  Future<void> clear() async {
    await _box.remove(_storageKey);
  }

  bool contains(LocationResult location) {
    return getRecent().contains(location);
  }
}