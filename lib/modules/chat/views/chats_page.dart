import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import 'package:teamomarket/app/utils/time-utils.dart';
import '../../../app/constants/app_constants.dart';
import '../../../app/utils/app_colors.dart';
import '../../../app/utils/custom_alert.dart';
import '../../../app/widgets/custom_widget.dart';
import '../controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController controller = Get.find<ChatController>();

  late final String chatId;
  String get currentUserId => userInfo?['id'];

  @override
  void initState() {
    super.initState();

    chatId = Get.arguments as String;

    controller.listenChat(chatId);
    controller.listenMessages(chatId);
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.log.i(controller.currentChat);

    return Obx((){
      final chat = controller.currentChat.value;
      final isSeller = chat?.sellerId == controller.currentUserId;
      final displayName = isSeller ? chat?.buyerName : chat?.sellerName;
      final displayPhoto = isSeller ? chat?.buyerPhoto : chat?.sellerPhoto;
      final receiverId = isSeller ? chat?.buyerId : chat?.sellerId;
      if(chat == null){
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
     return Scaffold(
        backgroundColor: const Color(0xffF5F7FA),
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          title: Row(
            children: [

              /// Seller Avatar
              if ((displayPhoto ?? '').isNotEmpty)
                SizedBox(
                  width: 42,
                  height: 42,
                  child: ClipOval(
                    child: CustomWidget.getImage(
                      displayPhoto!,
                    ),
                  ),
                )
              else
                const CircleAvatar(
                  radius: 21,
                  backgroundColor: Color(0xffECECEC),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Text(
                      displayName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      "Online",
                      style: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: Column(
          children: [

            //------------------------------------------------------------------
            // Product Card
            //------------------------------------------------------------------

            Container(
              margin: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                8,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(18),
              ),
              child: InkWell(
                borderRadius:
                BorderRadius.circular(18),
                onTap: () {
                  // TODO
                  // Navigate back to Product Details
                },
                child: Row(
                  children: [

                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(12),
                      child: SizedBox(
                        width: 72,
                        height: 72,
                        child: CustomWidget.getImage(
                          controller.currentChat.value!.productImage,
                          shape: BoxShape.rectangle,
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            controller.currentChat.value!.productTitle,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "₹ ${controller.currentChat.value?.productPrice.toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              color:
                              AppColors.primary,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "View Product >",
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight:
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //------------------------------------------------------------------
            // Messages
            //------------------------------------------------------------------

            Expanded(
              child: Obx(() {
                if (controller.isMessagesLoading.value) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (controller.messages.isEmpty) {
                  return const Center(
                    child: Text(
                      "Start the conversation 👋",
                    ),
                  );
                }

                // ===== Part 2 starts here =====
                return ListView.separated(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.fromLTRB(
                    12,
                    8,
                    12,
                    12,
                  ),
                  itemCount: controller.messages.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(height: 8),
                  itemBuilder: (_, index) {
                    final message = controller.messages[index];

                    final isMine =
                        message.senderId == currentUserId;

                    return Align(
                      alignment: isMine
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width *
                              .75,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isMine
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft:
                              const Radius.circular(18),
                              topRight:
                              const Radius.circular(18),
                              bottomLeft: Radius.circular(
                                isMine ? 18 : 4,
                              ),
                              bottomRight: Radius.circular(
                                isMine ? 4 : 18,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(
                                  alpha: 0.05,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isMine
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [

                              /// Message

                              Text(
                                message.message,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isMine
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 6),

                              /// Time + Seen

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [

                                  Text(
                                    TimeUtils.formatCompactTime(
                                      message.createdAt,
                                    ),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isMine
                                          ? Colors.white70
                                          : Colors.grey,
                                    ),
                                  ),

                                  if (isMine) ...[
                                    const SizedBox(width: 4),

                                    Icon(
                                      message.isSeen
                                          ? Icons.done_all
                                          : Icons.done,
                                      size: 15,
                                      color: message.isSeen
                                          ? Colors.lightBlueAccent
                                          : Colors.white70,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),

            // ===== Part 3 =====
            SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  10,
                  10,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffECECEC),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.end,
                  children: [

                    //------------------------------------------------------------------
                    // Attachment
                    //------------------------------------------------------------------

                    IconButton(
                      onPressed: () {
                        CustomAlert.infoAlert(
                          title: "Coming Soon",
                          "Image sharing will be available soon.",
                        );
                      },
                      icon: const Icon(
                        Icons.attach_file_rounded,
                      ),
                    ),

                    //------------------------------------------------------------------
                    // TextField
                    //------------------------------------------------------------------

                    Expanded(
                      child: TextField(
                        controller:
                        controller.messageController,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction:
                        TextInputAction.send,
                        onSubmitted: (_) {
                          controller.sendMessage(
                            receiverId: receiverId!,
                          );
                        },
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          filled: true,
                          fillColor:
                          const Color(0xffF5F7FA),
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                            borderSide:
                            BorderSide.none,
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                            borderSide:
                            BorderSide.none,
                          ),
                          focusedBorder:
                          OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                            borderSide:
                            const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    //------------------------------------------------------------------
                    // Send
                    //------------------------------------------------------------------

                    SizedBox(
                      width: 48,
                      height: 48,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          backgroundColor:
                          AppColors.primary,
                        ),
                        onPressed: () async {
                          await controller.sendMessage(
                            receiverId: chat.sellerId,
                          );
                        },
                        child: const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}