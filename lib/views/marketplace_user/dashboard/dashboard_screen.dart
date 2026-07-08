import 'package:flutter/material.dart';

import 'account_page.dart';
import 'categories_page.dart';
import 'chats_page.dart';
import 'home_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    CategoriesPage(),
    ChatsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF4F46E5);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: primary,
        shape: const CircleBorder(),
        onPressed: () {
          // TODO: Open Sell Screen
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFE5E7EB), // Light grey divider
                width: 1,
              ),
            ),
          ),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,

            child: SizedBox(
              height: 50,
              child: Row(
            children: [

              Expanded(
                child: _NavItem(
                  selected: currentIndex == 0,
                  icon: currentIndex == 0
                      ? Icons.home
                      : Icons.home_outlined,
                  label: "Home",
                  onTap: () {
                    setState(() {
                      currentIndex = 0;
                    });
                  },
                ),
              ),

              Expanded(
                child: _NavItem(
                  selected: currentIndex == 1,
                  icon: currentIndex == 1
                      ? Icons.grid_view_rounded
                      : Icons.grid_view_outlined,
                  label: "Explore",
                  onTap: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                ),
              ),

              // Space for FAB
              const SizedBox(width: 70),

              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [

                    _NavItem(
                      selected: currentIndex == 2,
                      icon: currentIndex == 2
                          ? Icons.chat
                          : Icons.chat_bubble_outline,
                      label: "Chats",
                      onTap: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                    ),

                    Positioned(
                      right: 22,
                      top: 8,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Expanded(
                child: _NavItem(
                  selected: currentIndex == 3,
                  icon: currentIndex == 3
                      ? Icons.person
                      : Icons.person_outline,
                  label: "Account",
                  onTap: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    ));
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
    const primary = Color(0xFF4F46E5);

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                icon,
                key: ValueKey(icon),
                color: selected ? primary : Colors.grey,
                size: selected ? 24 : 22,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                selected ? FontWeight.w700 : FontWeight.w500,
                color:
                selected ? primary : Colors.grey.shade600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}