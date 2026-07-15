import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../product/models/product_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../repositories/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository _repository = ChatRepository();

  final RxList<ChatModel> chats = <ChatModel>[].obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;

  final RxBool isChatsLoading = false.obs;
  final RxBool isMessagesLoading = false.obs;

  final TextEditingController messageController = TextEditingController();

  String? currentChatId;

  @override
  void onInit() {
    super.onInit();
    fetchChats();
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  //--------------------------------------------------------------------------
  // Chats
  //--------------------------------------------------------------------------

  Future<void> fetchChats() async {
    isChatsLoading.value = true;

    chats.assignAll(await _repository.getChats());

    isChatsLoading.value = false;
  }

  //--------------------------------------------------------------------------
  // Messages
  //--------------------------------------------------------------------------

  Future<void> fetchMessages(String chatId) async {
    currentChatId = chatId;

    messages.clear(); // <-- Clear old messages immediately

    isMessagesLoading.value = true;

    final data = await _repository.getMessages(chatId);

    messages.assignAll(data);

    markAsRead(chatId);

    isMessagesLoading.value = false;
  }

  //--------------------------------------------------------------------------
  // Send Message
  //--------------------------------------------------------------------------

  void sendMessage({
    required String senderId,
    required String receiverId,
  }) {
    final text = messageController.text.trim();

    if (text.isEmpty || currentChatId == null) return;

    final message = MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: currentChatId!,
      senderId: senderId,
      receiverId: receiverId,
      type: MessageType.text,
      message: text,
      isSeen: false,
      createdAt: DateTime.now(),
    );

    messages.add(message);

    final index = chats.indexWhere((e) => e.id == currentChatId);

    if (index != -1) {
      chats[index] = chats[index].copyWith(
        lastMessage: text,
        lastMessageType: MessageType.text,
        lastMessageTime: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    messageController.clear();
  }

  //--------------------------------------------------------------------------
  // Mark Read
  //--------------------------------------------------------------------------

  void markAsRead(String chatId) {
    final index = chats.indexWhere((e) => e.id == chatId);

    if (index == -1) return;

    chats[index] = chats[index].copyWith(
      unreadCount: 0,
    );
  }

  Future<void> openChat(ProductModel product) async {
    final chat = await _repository.getOrCreateChat(product);

    Get.toNamed(
      Routes.chat,
      arguments: chat,
    );
  }
}