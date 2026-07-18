import 'package:get/get.dart';
import 'package:teamomarket/modules/banner/repository/banner_repository.dart';

import '../../../app/utils/custom_alert.dart';
import '../models/banner_model.dart';

class BannerManagementController extends GetxController {
  final BannerRepository _repository = BannerRepository();

  final RxList<BannerModel> allBanners = <BannerModel>[].obs;
  final RxList<BannerModel> activeBanners = <BannerModel>[].obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllBanners();
    loadActiveBanners();
  }

  Future<void> loadAllBanners() async {
    await _load(
          () => _repository.getBanners(),
      allBanners,
    );
  }

  Future<void> loadActiveBanners() async {
    await _load(
          () => _repository.getBanners(isActive: true),
      activeBanners,
    );
  }

  Future<void> _load(
      Future<List<BannerModel>> Function() loader,
      RxList<BannerModel> target,
      ) async {
    try {
      isLoading.value = true;
      target.assignAll(await loader());
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteBanner(BannerModel banner) async {
    final confirm = await CustomAlert.confirmAlert(
      "Are you sure you want to delete this banner?",
      confirmText: "Delete",
    );

    if (confirm != true) return;

    try {
      await _repository.deleteBanner(banner.id);

      allBanners.removeWhere(
            (e) => e.id == banner.id,
      );

      CustomAlert.successAlert(
        title: "Deleted",
        "Banner deleted successfully.",
      );
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    }
  }


  void onBannerTap(BannerModel banner) {
    switch (banner.actionType) {
      case "category":
      // TODO: Navigate to category
        break;

      case "product":
      // TODO: Navigate to product details
        break;

      case "url":
      // TODO: Launch external URL
        break;

      default:
        break;
    }
  }
}