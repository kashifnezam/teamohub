import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import '../../../app/routes/app_routes.dart';
import '../../../app/utils/custom_alert.dart';
import '../../product/models/product_model.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../repositories/chat_repository.dart';

class ChatController extends GetxController {
  final ChatRepository _repository = ChatRepository();

  StreamSubscription<List<ChatModel>>? _chatSubscription;
  StreamSubscription<List<MessageModel>>? _messageSubscription;

  final RxList<ChatModel> chats = <ChatModel>[].obs;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final Rxn<ChatModel> currentChat = Rxn<ChatModel>();
  final RxBool isChatsLoading = false.obs;
  final RxBool isMessagesLoading = false.obs;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  StreamSubscription<ChatModel>? _currentChatSubscription;

  String? currentChatId;

  @override
  void onInit() {
    super.onInit();
    listenChats();
  }

  String get currentUserId => userInfo?['id'] ?? '';
  List<ChatModel> get buyingChats => chats.where((e) => e.buyerId == currentUserId).toList();
  List<ChatModel> get sellingChats => chats.where((e) => e.sellerId == currentUserId).toList();
  bool get hasUnreadBuying => buyingChats.any((e) => e.unreadCount > 0);
  bool get hasUnreadSelling => sellingChats.any((e) => e.unreadCount > 0);
  int get buyingUnreadCount => buyingChats.fold(0, (sum, e) => sum + e.unreadCount);
  int get sellingUnreadCount => sellingChats.fold(0, (sum, e) => sum + e.unreadCount);
  int get totalUnreadCount => chats.fold(0, (sum, chat) => sum + chat.unreadCount);
  bool get hasUnreadChats => totalUnreadCount > 0;

  //--------------------------------------------------------------------------
  // Chats
  //--------------------------------------------------------------------------
  void listenChat(String chatId) {
    _currentChatSubscription?.cancel();

    _currentChatSubscription =
        _repository.streamChat(chatId).listen(
              (chat) {
            currentChat.value = chat;
          },
          onError: (e) {
            CustomAlert.errorAlert(
              title: "Error",
              e.toString(),
            );
          },
        );
  }

  void listenChats() {
    if(currentUserId.isEmpty) return;
    isChatsLoading.value = true;
    _chatSubscription?.cancel();

    _chatSubscription = _repository.streamChats().listen(
          (data) {
        chats.assignAll(data);
        isChatsLoading.value = false;
      },
      onError: (e) {
        isChatsLoading.value = false;
        CustomAlert.errorAlert(
          title: "Error",
          e.toString(),
        );
      },
    );
  }

  //--------------------------------------------------------------------------
  // Messages
  //--------------------------------------------------------------------------

  void listenMessages(String chatId) {
    currentChatId = chatId;

    isMessagesLoading.value = true;

    _messageSubscription?.cancel();

    _repository.markMessagesAsRead(chatId);

    _messageSubscription =
        _repository.streamMessages(chatId).listen(
              (data) {
            messages.assignAll(data);

            isMessagesLoading.value = false;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!scrollController.hasClients) return;

              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              );
            });
          },
          onError: (e) {
            isMessagesLoading.value = false;

            CustomAlert.errorAlert(
              title: "Error",
              e.toString(),
            );
          },
        );
  }


  //--------------------------------------------------------------------------
  // Send Message
  //--------------------------------------------------------------------------

  Future<void> sendMessage({
    required String receiverId,
  }) async {
    final chat = currentChat.value;
    if (chat == null) return;

    final text = messageController.text.trim();
    if (text.isEmpty) return;

    try {
      await _repository.sendMessage(
        chatId: chat.id,
        senderId: currentUserId,
        receiverId: receiverId,
        text: text,
      );

      messageController.clear();
    } catch (e) {
      CustomAlert.errorAlert(
        title: "Error",
        e.toString(),
      );
    }
  }

  //--------------------------------------------------------------------------
  // Mark Read
  //--------------------------------------------------------------------------

  Future<void> markAsRead(String chatId) async {
    await _repository.markMessagesAsRead(chatId);
  }
  
  Future<void> callChat(ProductModel product) async {
    try {
      if (product.sellerId == userInfo?["id"]) {
        CustomAlert.errorAlert(
          title: "Not allowed",
          "You can't chat with yourself.",
        );
        return;
      }
      final confirmAlert = await CustomAlert.confirmAlert("Deal with precaution", title: "Fraud Alert", confirmText: "Get number");
      if(!confirmAlert) return;
      isChatsLoading.value = true;
      CustomAlert.loadAlert("Loading chat..");
      final chatId = await _repository.getOrCreateChat(
        sellerId: product.sellerId,
        sellerName: product.sellerName!,
        productPrice: product.price,
        sellerPhoto: product.sellerPhoto,

        buyerId: userInfo?['id'],
        buyerName: userInfo?['name'] ?? '',
        buyerPhoto:  userInfo?['photo'] ?? '',

        productId: product.id,
        productTitle: product.title,
        productImage: product.images.first,
        chatText: "I'm interested in Lets talk on ${userInfo?['phone']}"
      );
      CustomAlert.dismissAlert();
      Get.toNamed(
        AppRoutes.chat,
        arguments: chatId,
      );

      isChatsLoading.value = false;
    } catch (e) {
      isChatsLoading.value = false;

      CustomAlert.errorAlert(
        title: "Unable to open chat",
        e.toString(),
      );
    }
  }

  Future<void> openChat(ProductModel product) async {
    try {
      if (product.sellerId == userInfo?["id"]) {
        CustomAlert.errorAlert(
          title: "Not allowed",
          "You can't chat with yourself.",
        );
        return;
      }
      isChatsLoading.value = true;
      CustomAlert.loadAlert("Loading chat..");
      final chatId = await _repository.getOrCreateChat(
        sellerId: product.sellerId,
        sellerName: product.sellerName!,
        productPrice: product.price,
        sellerPhoto: product.sellerPhoto,

        buyerId: userInfo?['id'],
        buyerName: userInfo?['name'] ?? '',
        buyerPhoto:  userInfo?['photo'] ?? '',

        productId: product.id,
        productTitle: product.title,
        productImage: product.images.first,
        chatText: "Hey, I'm interested in the ads"
      );
      CustomAlert.dismissAlert();
      Get.toNamed(
        AppRoutes.chat,
        arguments: chatId,
      );
      isChatsLoading.value = false;
    } catch (e) {
      isChatsLoading.value = false;

      CustomAlert.errorAlert(
        title: "Unable to open chat",
        e.toString(),
      );
    }
  }

  Future<void> openAgentChat({required Map<String, dynamic> request}) async {
    try {
      isChatsLoading.value = true;
      CustomAlert.loadAlert("Loading chat...");

      final chatId = await _repository.getOrCreateAgentChat(
        agentId: request["agentId"],
        agentName: request["agentName"],
        agentPhoto: request["agentPhoto"],

        clientId: request["userId"],
        clientName: request["userName"],
        clientPhoto: request["userImage"],

        requestId: request["id"],

        initialMessage:
        "Hi, I need your help regarding my request.",
      );

      CustomAlert.dismissAlert();

      isChatsLoading.value = false;

      Get.toNamed(
        AppRoutes.chat,
        arguments: chatId,
      );
    } catch (e) {
      CustomAlert.dismissAlert();

      isChatsLoading.value = false;

      CustomAlert.errorAlert(
        title: "Unable to open chat",
        e.toString(),
      );
    }
  }

  @override
  void onClose() {
    _chatSubscription?.cancel();
    _messageSubscription?.cancel();
    _currentChatSubscription?.cancel();

    messageController.dispose();
    scrollController.dispose();

    super.onClose();
  }
}