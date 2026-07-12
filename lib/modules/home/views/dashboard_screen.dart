import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';

import '../../../app/utils/app_colors.dart';
import '../../../../modules/home/views/account_page.dart';
import '../../category/views/categories_page.dart';
import '../../chat/views/chats_page.dart';
import 'home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  final pages = [
    const HomePage(),
    const ChatsPage(),
    const ChatsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
          });
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

        floatingActionButton: Column(
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
                      Color(0xFF6366F1), // Indigo
                      Color(0xFF8B5CF6), // Purple
                      Color(0xFF06B6D4), // Cyan
                      Color(0xFF3B82F6), // Blue
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
        ),

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

                Expanded(
                  child: _NavItem(
                    selected: currentIndex == 0,
                    icon: currentIndex == 0
                        ? Icons.home
                        : Icons.home_outlined,
                    label: "Home",
                    onTap: () => setState(() => currentIndex = 0),
                  ),
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
                        onTap: () => setState(() => currentIndex = 1),
                      ),

                      Positioned(
                        right: 18,
                        top: -1,
                        child: Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "2",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(width: 66),

                Expanded(
                  child: _NavItem(
                    selected: currentIndex == 2,
                    icon: currentIndex == 2
                        ? Icons.grid_view_rounded
                        : Icons.grid_view_outlined,
                    label: "Explore",
                    onTap: () => setState(() => currentIndex = 2),
                  ),
                ),

                const SizedBox(width: 25),

                Expanded(
                  child: _NavItem(
                    selected: currentIndex == 3,
                    icon: currentIndex == 3
                        ? Icons.person
                        : Icons.person_outline,
                    label: "Account",
                    onTap: () => setState(() => currentIndex = 3),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
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