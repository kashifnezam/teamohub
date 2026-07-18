import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';
import 'package:teamomarket/modules/profile/views/profile_page.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/utils/custom_alert.dart';
import '../../chat/views/chat_list_page.dart';
import 'home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;


  static List<Widget> pages = [
    HomePage(),
    ChatListPage(),
    ChatListPage(), // Replace with ExplorePage later
    ProfilePage(),
  ];

  void _changeTab(int index) {
    if (currentIndex == index) return;

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        if (currentIndex != 0) {
          _changeTab(0);
          return;
        }

        final exit = await CustomAlert.confirmAlert(
          "",
          title: "Are you sure you want to exit?",
          confirmText: "Exit",
        );

        if (exit == true) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FA),

        body: IndexedStack(
          index: currentIndex,
          children: pages,
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,

        floatingActionButton: const _SellButton(),

        bottomNavigationBar: Material(
          elevation: 12,
          color: Colors.white,
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            color: Colors.white,
            height: 70,
            child: Row(
              children: [

                _buildNavItem(
                  index: 0,
                  selectedIcon: Icons.home,
                  unselectedIcon: Icons.home_outlined,
                  label: "Home",
                ),

                const SizedBox(width: 25),

                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [

                      _NavItem(
                        selected: currentIndex == 1,
                        icon: currentIndex == 1
                            ? Icons.chat
                            : Icons.chat_bubble_outline,
                        label: "Chats",
                        onTap: () => _changeTab(1),
                      ),

                      // const Positioned(
                      //   right: 18,
                      //   top: -1,
                      //   child: _ChatBadge(
                      //     count: "2",
                      //   ),
                      // ),

                    ],
                  ),
                ),

                const SizedBox(width: 66),

                _buildNavItem(
                  index: 2,
                  selectedIcon: Icons.grid_view_rounded,
                  unselectedIcon: Icons.grid_view_outlined,
                  label: "Explore",
                ),

                const SizedBox(width: 25),

                _buildNavItem(
                  index: 3,
                  selectedIcon: Icons.person,
                  unselectedIcon: Icons.person_outline,
                  label: "Account",
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildNavItem({
    required int index,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required String label,
  }) {
    return Expanded(
      child: _NavItem(
        selected: currentIndex == index,
        icon: currentIndex == index
            ? selectedIcon
            : unselectedIcon,
        label: label,
        onTap: () => _changeTab(index),
      ),
    );
  }
}
/*class _ChatBadge extends StatelessWidget {
  final String count;

  const _ChatBadge({
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        count,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}*/
class _SellButton extends StatelessWidget {
  const _SellButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 25),

        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.categories);
          },
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                  Color(0xFF06B6D4),
                  Color(0xFF3B82F6),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ),
        ),

        const SizedBox(height: 13),

        const Text(
          "Sell",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AnimatedScale(
              scale: selected ? 1.08 : 1,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: Icon(
                icon,
                color: selected
                    ? AppColors.primary
                    : Colors.grey.shade600,
                size: selected ? 22 : 20,
              ),
            ),

            const SizedBox(height: 3),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 180),
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                selected ? FontWeight.w700 : FontWeight.w500,
                color: selected
                    ? AppColors.primary
                    : Colors.grey.shade600,
              ),
              child: Text(label),
            ),

          ],
        ),
      ),
    );
  }

}