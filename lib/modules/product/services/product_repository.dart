import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  ///------------------------------------------------
  /// Generate Product Id
  ///------------------------------------------------
  String generateProductId() {
    return _products.doc().id;
  }

  ///------------------------------------------------
  /// Create Product
  ///------------------------------------------------
  Future<void> createProduct(ProductModel product) async {
    await _products.doc(product.id).set(product.toJson());
  }

  ///------------------------------------------------
  /// Get All Products
  ///------------------------------------------------
  Future<List<ProductModel>> getProducts() async {
    final snapshot = await _products
        .where("isDeleted", isEqualTo: false)
        .where("status", isEqualTo: ProductStatus.active.name)
        .orderBy("publishedAt", descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data()))
        .toList();
  }

  ///------------------------------------------------
  /// Stream All Products
  ///------------------------------------------------
  Stream<List<ProductModel>> streamProducts() {
    return _products
        .where("isDeleted", isEqualTo: false)
        .where("status", isEqualTo: ProductStatus.active.name)
        .orderBy("publishedAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => ProductModel.fromJson(doc.data()))
          .toList(),
    );
  }

  ///------------------------------------------------
  /// Get Single Product
  ///------------------------------------------------
  Future<ProductModel?> getProduct(String productId) async {
    final doc = await _products.doc(productId).get();

    if (!doc.exists) return null;

    return ProductModel.fromJson(doc.data()!);
  }

  ///------------------------------------------------
  /// Update Product
  ///------------------------------------------------
  Future<void> updateProduct(ProductModel product) async {
    await _products.doc(product.id).update(product.toJson());
  }

  ///------------------------------------------------
  /// Soft Delete
  ///------------------------------------------------
  Future<void> deleteProduct(String productId) async {
    await _products.doc(productId).update({
      "isDeleted": true,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}