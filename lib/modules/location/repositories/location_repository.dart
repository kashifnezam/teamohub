import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/constants/firestore_collections.dart';
import '../data/city_list.dart';
import '../data/country_list.dart';
import '../data/state_list.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/state_model.dart';

class LocationRepository {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  //----------------------------------------------------------
  // Countries
  //----------------------------------------------------------

  Future<List<CountryModel>> getCountries() async {
    /// Firestore (Future)

    /*
    final snapshot = await _firestore
        .collection(FirestoreCollections.countries)
        .where("isActive", isEqualTo: true)
        .orderBy("order")
        .get();

    return snapshot.docs
        .map(
          (e) => CountryModel.fromMap(e.data()),
        )
        .toList();
    */


    return countries;
  }

  //----------------------------------------------------------
  // States
  //----------------------------------------------------------

  Future<List<StateModel>> getStates(
      String countryId,
      ) async {
    /// Firestore (Future)

    /*
    final snapshot = await _firestore
        .collection(FirestoreCollections.states)
        .where("countryId", isEqualTo: countryId)
        .where("isActive", isEqualTo: true)
        .orderBy("order")
        .get();

    return snapshot.docs
        .map(
          (e) => StateModel.fromMap(e.data()),
        )
        .toList();
    */

    return states
        .where(
          (e) => e.countryId == countryId,
    )
        .toList();
  }

  //----------------------------------------------------------
  // Cities
  //----------------------------------------------------------

  Future<List<CityModel>> getCities(
      String stateId,
      ) async {
    /// Firestore (Future)

    /*
    final snapshot = await _firestore
        .collection(FirestoreCollections.cities)
        .where("stateId", isEqualTo: stateId)
        .where("isActive", isEqualTo: true)
        .orderBy("order")
        .get();

    return snapshot.docs
        .map(
          (e) => CityModel.fromMap(e.data()),
        )
        .toList();
    */

    return cities
        .where(
          (e) => e.stateId == stateId,
    )
        .toList();
  }
}