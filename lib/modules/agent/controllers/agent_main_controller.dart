import 'package:get/get.dart';

class AgentMainController extends GetxController {
  /// Current bottom navigation index
  final RxInt currentIndex = 0.obs;

  void changeTab(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }
}