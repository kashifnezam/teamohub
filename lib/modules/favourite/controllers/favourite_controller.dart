import 'package:get/get.dart';
import 'package:teamomarket/app/utils/offline_data.dart';

import '../../../app/routes/middlewares/auth_helper.dart';
import '../../../app/utils/custom_alert.dart';
import '../repositories/favourite_repo.dart';

class FavouriteController extends GetxController {
  static FavouriteController get to => Get.find();

  final RxSet<String> favouriteIds = <String>{}.obs;

  final RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    listenFavourite();
  }

  listenFavourite(){
    if(userInfo?['id'] != null)
    FavouriteRepo.favourites().listen((event) {
      favouriteIds.assignAll(
        event.map((e) => e.productId),
      );
    });
  }

  bool isFavourite(String productId) {
    return favouriteIds.contains(productId);
  }

  Future<void> toggleFavourite(String productId) async {
    if (!await AuthHelper.requireLogin(
      message: "Login to post your ad.",
    )) return;

    if(productId.isEmpty) return;
    final wasFavourite = favouriteIds.contains(productId);
    try {
      loading.value = true;
      if (wasFavourite) {
        favouriteIds.remove(productId);
      } else {
        favouriteIds.add(productId);
      }
     await FavouriteRepo.toggle(productId);

    } catch (e) {
      // Rollback
      if (wasFavourite) {
        favouriteIds.add(productId);
      } else {
        favouriteIds.remove(productId);
      }
      CustomAlert.errorAlert(
        title: "Something went wrong",
        e.toString(),
      );
    } finally {
      loading.value = false;
    }
  }
}