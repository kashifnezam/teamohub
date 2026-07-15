import '../../product/models/product_model.dart';
import '../data/dummy_chats.dart';
import '../data/dummy_messages.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  Future<List<ChatModel>> getChats() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return dummyChats;
  }

  Future<List<MessageModel>> getMessages(String chatId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DummyMessages.getMessages(chatId);
  }

  Future<ChatModel> getOrCreateChat(ProductModel product) async {
    return ChatModel(
      id: 'chat_${product.id}',
      productId: product.id,
      productTitle: product.title,
      productImage: product.images.first,

      sellerId: product.sellerId,
      sellerName: product.sellerName! ,
      sellerPhoto: product.sellerPhoto,

      buyerId: 'buyer_1',
      buyerName: 'Current User',
      buyerPhoto: null,

      lastMessage: '',
      lastMessageType: MessageType.text,
      lastMessageTime: DateTime.now(),

      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}