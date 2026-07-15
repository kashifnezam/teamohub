import 'package:get/get.dart';

import '../../../app/utils/custom_alert.dart';
import '../../product/models/product_model.dart';
import '../../product/services/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;

      products.assignAll(
        await _repository.getProducts(),
      );
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}