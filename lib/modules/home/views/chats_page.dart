import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatsPage extends GetView<ChatsController> {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff101828),
        title: const Text(
          "Chats",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          /// Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() {
              return Container(
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F4F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _tabButton(
                      title: "Buying",
                      index: 0,
                    ),
                    _tabButton(
                      title: "Selling",
                      index: 1,
                    ),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 18),

          Expanded(
            child: Obx(() {
              final chats = controller.selectedTab.value == 0
                  ? controller.buyingChats
                  : controller.sellingChats;

              if (chats.isEmpty) {
                return _EmptyChatView(
                  isBuying: controller.selectedTab.value == 0,
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: chats.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Color(0xffEAECF0),
                ),
                itemBuilder: (_, index) {
                  final chat = chats[index];

                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xffEAF2FF),
                      child: Text(
                        chat['name']![0],
                        style: const TextStyle(
                          color: Color(0xff4F46E5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      chat['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        chat['msg']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: Text(
                      chat['time']!,
                      style: const TextStyle(
                        color: Color(0xff667085),
                        fontSize: 13,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _tabButton({
    required String title,
    required int index,
  }) {
    final selected = controller.selectedTab.value == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 8,
              )
            ]
                : [],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected
                    ? const Color(0xff4F46E5)
                    : const Color(0xff667085),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class ChatsController extends GetxController {
  final selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }

  final buyingChats = [
   /* {
      'name': 'Aarav',
      'msg': 'Is the sofa still available?',
      'time': '2m',
    },
    {
      'name': 'Rohan',
      'msg': 'Can you lower the price?',
      'time': '10m',
    },
    {
      'name': 'Ishita',
      'msg': 'Please share more photos.',
      'time': '1h',
    },*/
  ];

  final sellingChats = [
    /*{
      'name': 'Priya',
      'msg': 'I can pick it up today.',
      'time': '5m',
    },
    {
      'name': 'Rahul',
      'msg': 'Is this item negotiable?',
      'time': '18m',
    },
    {
      'name': 'Neha',
      'msg': 'Thank you!',
      'time': 'Yesterday',
    },*/
  ];
}

class _EmptyChatView extends StatelessWidget {
  final bool isBuying;

  const _EmptyChatView({
    required this.isBuying,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 24),
            Text(
              isBuying ? "No Buying Chats Yet" : "No Selling Chats Yet",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isBuying
                  ? "Start chatting with sellers to ask questions and negotiate before buying."
                  : "List your first item to start receiving messages from interested buyers.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff667085),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (isBuying) {
                    // Navigate to Home/Marketplace
                    // Get.offAllNamed(Routes.home);
                  } else {
                    // Navigate to Sell Page
                    // Get.toNamed(Routes.sellItem);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F46E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  isBuying ? "Start Messaging" : "Start Selling",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}