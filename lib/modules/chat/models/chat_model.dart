import 'message_model.dart';

class ChatModel {
  final String id;

  final String productId;
  final String productTitle;
  final String productImage;

  final String sellerId;
  final String sellerName;
  final String? sellerPhoto;

  final String buyerId;
  final String buyerName;
  final String? buyerPhoto;

  final String lastMessage;
  final MessageType lastMessageType;
  final DateTime lastMessageTime;

  final int unreadCount;

  final bool isProductAvailable;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ChatModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.sellerId,
    required this.sellerName,
    this.sellerPhoto,
    required this.buyerId,
    required this.buyerName,
    this.buyerPhoto,
    required this.lastMessage,
    this.lastMessageType = MessageType.text,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isProductAvailable = true,
    required this.createdAt,
    required this.updatedAt,
  });

  ChatModel copyWith({
    String? lastMessage,
    MessageType? lastMessageType,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isProductAvailable,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImage: productImage,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerPhoto: sellerPhoto,
      buyerId: buyerId,
      buyerName: buyerName,
      buyerPhoto: buyerPhoto,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isProductAvailable:
      isProductAvailable ?? this.isProductAvailable,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return '''
ChatModel(
  id: $id,
  sellerName: $sellerName,
  productTitle: $productTitle,
  lastMessage: $lastMessage,
  productId: $productId,
  productImage: $productImage,
  sellerId: $sellerId,
  sellerPhoto: $sellerPhoto,
)
''';
  }
}