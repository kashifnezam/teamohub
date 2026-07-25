import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teamomarket/app/constants/firebase_constants.dart';

import '../models/favourite_model.dart';

class FavouriteRepo {
  FavouriteRepo._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static CollectionReference<Map<String, dynamic>> get _favcollection => _firestore.collection(FirebaseConstants.favourites);

  static String get userId => _auth.currentUser!.uid;

  /// Add Favourite
  static Future<void> add(String productId) async {
    final doc = _favcollection.doc("${userId}_$productId");

    final favourite = FavouriteModel(
      id: doc.id,
      userId: userId,
      productId: productId,
      createdAt: DateTime.now(),
    );

    await doc.set(favourite.toMap());
  }

  /// Remove Favourite
  static Future<void> remove(String productId) async {
    await _favcollection.doc("${userId}_$productId").delete();
  }

  /// Check Favourite
  static Future<bool> isFavourite(String productId) async {
    final doc =
    await _favcollection.doc("${userId}_$productId").get();

    return doc.exists;
  }

  /// Toggle Favourite
  static Future<bool> toggle(String productId) async {
    final favouriteRef = _favcollection.doc("${userId}_$productId");

    final productRef = FirebaseFirestore.instance
        .collection("products")
        .doc(productId);

    return FirebaseFirestore.instance.runTransaction<bool>((transaction) async {
      final favDoc = await transaction.get(favouriteRef);
      final productDoc = await transaction.get(productRef);

      final currentLikes = (productDoc.data()?["likes"] as num?)?.toInt() ?? 0;

      if (favDoc.exists) {
        transaction.delete(favouriteRef);

        transaction.update(productRef, {
          "likes": currentLikes > 0 ? currentLikes - 1 : 0,
        });

        return false;
      }

      transaction.set(
        favouriteRef,
        FavouriteModel(
          id: favouriteRef.id,
          userId: userId,
          productId: productId,
          createdAt: DateTime.now(),
        ).toMap(),
      );

      transaction.update(productRef, {
        "likes": currentLikes + 1,
      });

      return true;
    });
  }

  /// User Favourites
  static Stream<List<FavouriteModel>> favourites() {
    return _favcollection
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(
          (event) => event.docs
          .map((e) => FavouriteModel.fromMap(e.data()))
          .toList(),
    );
  }
}