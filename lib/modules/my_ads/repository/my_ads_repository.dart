import '../../product/models/product_model.dart';
import '../services/my_ads_service.dart';

class MyAdsRepository {
  MyAdsRepository._();

  static final MyAdsRepository instance = MyAdsRepository._();

  final MyAdsService _service = MyAdsService.instance;

  /// Stream logged-in user's products
  Stream<List<ProductModel>> streamMyProducts(String uid) {
    return _service.streamMyProducts(uid);
  }

  /// Update product status
  Future<void> updateStatus({
    required String productId,
    required String status,
  }) {
    return _service.updateStatus(
      productId: productId,
      status: status,
    );
  }

  /// Delete product
  Future<void> deleteProduct(String productId) {
    return _service.updateProduct(productId: productId,data: {"isDeleted": true});
  }

  /// Update product
  Future<void> updateProduct({
    required String productId,
    required Map<String, dynamic> data,
  }) {
    return _service.updateProduct(
      productId: productId,
      data: data,
    );
  }
}