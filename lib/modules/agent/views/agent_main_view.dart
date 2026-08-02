import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/modules/agent/views/listings/agent_my_listings_view.dart';

import '../../../app/utils/custom_alert.dart';
import '../controllers/agent_main_controller.dart';
import '../tabs/account_tab.dart';
import '../tabs/clients_tab.dart';
import '../tabs/dashboard_tab.dart';


class AgentMainView extends GetView<AgentMainController> {
  const AgentMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          if (controller.currentIndex.value != 0) {
            controller.changeTab(0);
            return;
          }

          final exit = await CustomAlert.confirmAlert(
            title: "Exit Agent Dashboard",
            "Return to your normal TeamoMart account?",
          );

          if (exit == true) {
            Get.back();
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.currentIndex.value,
              children: const [
                DashboardTab(),
                ClientsTab(),
                AgentMyListingsView(),
                AccountTab(),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: controller.currentIndex.value,
            onDestinationSelected: controller.changeTab,
            height: 72,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.groups_outlined),
                selectedIcon: Icon(Icons.groups),
                label: "Clients",
              ),
              NavigationDestination(
                icon: Icon(Icons.campaign_outlined),
                selectedIcon: Icon(Icons.campaign),
                label: "Listing",
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}