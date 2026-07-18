import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../app/constants/firebase_constants.dart';
import '../../product/models/product_model.dart';

class MyAdsService {
  MyAdsService._();

  static final MyAdsService instance = MyAdsService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection(FirebaseConstants.products);

  /// Stream logged-in user's products
  Stream<List<ProductModel>> streamMyProducts(String uid) {
    return _products
        .where("sellerId", isEqualTo: uid)
        .where("isDeleted", isEqualTo: false)
        .orderBy("updatedAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => ProductModel.fromFirestore(doc))
          .toList(),
    );
  }

  /// Update product status
  Future<void> updateStatus({
    required String productId,
    required String status,
  }) async {
    await _products.doc(productId).update({
      "status": status,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }

  /// Delete product
  Future<void> deleteProduct(String productId) async {
    await _products.doc(productId).delete();
  }

  /// Update any product fields
  Future<void> updateProduct({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    data["updatedAt"] = FieldValue.serverTimestamp();

    await _products.doc(productId).update(data);
  }
}