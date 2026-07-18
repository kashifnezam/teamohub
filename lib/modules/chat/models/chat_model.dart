import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_model.dart';

class ChatModel {
  final String id;
  final double productPrice;
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
    required this.productPrice,
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
      productPrice: productPrice,
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
  factory ChatModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, {
        required String currentUserId,
      }) {
    final data = doc.data() ?? {};

    final seller = Map<String, dynamic>.from(data['sellerSnapshot'] ?? {});

    final buyer = Map<String, dynamic>.from(data['buyerSnapshot'] ?? {});

    final product = Map<String, dynamic>.from(data['productSnapshot'] ?? {});

    final unread = Map<String, dynamic>.from(data['unreadCounts'] ?? {});

    return ChatModel(
      id: doc.id,
      productId: data['productId'] ?? '',
      productTitle: product['title'] ?? '',
      productImage: product['image'] ?? '',
      productPrice:
      (product['price'] as num?)?.toDouble() ?? 0,

      sellerId: seller['id'] ?? '',
      sellerName: seller['name'] ?? '',
      sellerPhoto: seller['photo'],

      buyerId: buyer['id'] ?? '',
      buyerName: buyer['name'] ?? '',
      buyerPhoto: buyer['photo'],

      lastMessage: data['lastMessage'] ?? '',

      lastMessageType: MessageType.values.firstWhere(
            (e) => e.name == data['lastMessageType'],
        orElse: () => MessageType.text,
      ),

      lastMessageTime:
      (data['lastMessageTime'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),

      unreadCount: unread[currentUserId] ?? 0,

      isProductAvailable:
      data['isProductAvailable'] ?? true,

      createdAt:
      (data['createdAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),

      updatedAt:
      (data['updatedAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyerId': buyerId,
      'sellerId': sellerId,
      'productId': productId,

      'lastMessage': lastMessage,
      'lastMessageType': lastMessageType.name,
      'lastMessageTime': lastMessageTime,

      'createdAt': createdAt,
      'updatedAt': updatedAt,

      'participants': [
        buyerId,
        sellerId,
      ],

      'unreadCounts': {
        buyerId: 0,
        sellerId: 0,
      },

      'isProductAvailable': isProductAvailable,

      'productSnapshot': {
        'title': productTitle,
        'image': productImage,
        'price': productPrice,
      },

      'sellerSnapshot': {
        'id': sellerId,
        'name': sellerName,
        'photo': sellerPhoto,
      },

      'buyerSnapshot': {
        'id': buyerId,
        'name': buyerName,
        'photo': buyerPhoto,
      },
    };
  }
  ChatModel.empty()
      : id = '',
        productId = '',
        productTitle = '',
        productImage = '',
        productPrice = 0,
        sellerId = '',
        sellerName = '',
        sellerPhoto = null,
        buyerId = '',
        buyerName = '',
        buyerPhoto = null,
        lastMessage = '',
        lastMessageType = MessageType.text,
        lastMessageTime = DateTime.now(),
        unreadCount = 0,
        isProductAvailable = true,
        createdAt = DateTime.now(),
        updatedAt = DateTime.now();

  @override
  String toString() {
    return '''
      ChatModel(
        id: $id,
        sellerName: $sellerName,
        productTitle: $productTitle,
        productPrice: $productPrice,
        lastMessage: $lastMessage,
        productId: $productId,
        productImage: $productImage,
        sellerId: $sellerId,
        sellerPhoto: $sellerPhoto,
      )
      ''';
      }
}