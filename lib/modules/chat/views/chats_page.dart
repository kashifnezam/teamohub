import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/chat_controller.dart';
import '../models/chat_model.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = Get.find<ChatController>();
  late final ChatModel chat;
  final currentUserId = 'buyer_1';

  @override
  void initState() {
    super.initState();
    chat = Get.arguments as ChatModel;
    controller.fetchMessages(chat.id);

  }


  @override
  Widget build(BuildContext context) {
    print(chat.sellerPhoto == '');
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            chat.sellerPhoto != null
                ? SizedBox(
              width: 40,
              height: 40,
              child: CustomWidget.getImage(chat.sellerPhoto!),
            )
                : const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFE0E0E0),
              child: Icon(
                Icons.person_rounded,
                color: Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                chat.sellerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [

          // Product Card

          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CustomWidget.getImage(chat.productImage, shape: BoxShape.rectangle),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      Text(
                        chat.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      TextButton(
                        onPressed: () {},
                        child: const Text("View Product >"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Messages

          Expanded(
            child: Obx(() {
              if (controller.isMessagesLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.messages.isEmpty) {
                return const Center(
                  child: Text("No chats found"),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (_, index) {
                  final message =
                  controller.messages[index];

                  final isMine =
                      message.senderId == currentUserId;

                  return Align(
                    alignment: isMine
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(
                        maxWidth: 300,
                      ),
                      decoration: BoxDecoration(
                        color: isMine
                            ? AppColors.primary
                            : Colors.white,
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: isMine
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Input

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.attach_file,
                    ),
                  ),

                  Expanded(
                    child: TextField(
                      controller:
                      controller.messageController,
                      decoration: InputDecoration(
                        hintText: "Message...",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        controller.sendMessage(
                          senderId: currentUserId,
                          receiverId: chat.sellerId,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}