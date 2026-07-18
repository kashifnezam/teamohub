import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/constants/app_constants.dart';
import 'package:teamomarket/app/routes/app_routes.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/chat_controller.dart';

class ChatListPage extends GetView<ChatController> {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Chats"),
        centerTitle: false,
      ),

      body: Obx(() {
        if (controller.isChatsLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.chats.isEmpty) {
          return const Center(
            child: Text("No chats found"),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: controller.chats.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            final chat = controller.chats[index];
            final isSeller = chat.sellerId == controller.currentUserId;

            final displayName = isSeller ? chat.buyerName : chat.sellerName;

            final displayPhoto = isSeller ? chat.buyerPhoto : chat.sellerPhoto;

            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Get.toNamed(
                  Routes.chat,
                  arguments: chat.id,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [

                    // Seller Photo
                    displayPhoto != null && displayPhoto.isNotEmpty
                        ?  CustomWidget.getImage(chat.productImage)
                        : const CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFFE0E0E0),
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            displayName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            chat.productTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [

                        Text(
                          _time(chat.lastMessageTime),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 10),

                        if (chat.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Text(
                              chat.unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(width: 10),

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(8),
                      child: CustomWidget.getImage(
                        chat.productImage,
                        shape: BoxShape.rectangle,
                      )
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  String _time(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m";
    }

    if (diff.inHours < 24) {
      return "${diff.inHours}h";
    }

    return "${diff.inDays}d";
  }
}