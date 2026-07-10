import 'dart:convert';

class ChatModel {
  final String id;

  /// Product
  final String productId;

  /// Participants
  final String buyerId;
  final String sellerId;

  /// Optional Agent
  final String? agentId;

  /// Last Message Preview
  final String lastMessage;

  /// Last Message Sender
  final String lastMessageSenderId;

  /// Last Message Time
  final DateTime lastMessageAt;

  /// Unread Counts
  final int buyerUnreadCount;
  final int sellerUnreadCount;

  /// Active / Archived / Blocked
  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;

  const ChatModel({
    required this.id,
    required this.productId,
    required this.buyerId,
    required this.sellerId,
    this.agentId,
    this.lastMessage = '',
    this.lastMessageSenderId = '',
    required this.lastMessageAt,
    this.buyerUnreadCount = 0,
    this.sellerUnreadCount = 0,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  ChatModel copyWith({
    String? id,
    String? productId,
    String? buyerId,
    String? sellerId,
    String? agentId,
    String? lastMessage,
    String? lastMessageSenderId,
    DateTime? lastMessageAt,
    int? buyerUnreadCount,
    int? sellerUnreadCount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChatModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      buyerId: buyerId ?? this.buyerId,
      sellerId: sellerId ?? this.sellerId,
      agentId: agentId ?? this.agentId,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageSenderId:
      lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      buyerUnreadCount:
      buyerUnreadCount ?? this.buyerUnreadCount,
      sellerUnreadCount:
      sellerUnreadCount ?? this.sellerUnreadCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'buyerId': buyerId,
      'sellerId': sellerId,
      'agentId': agentId,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageAt': lastMessageAt.millisecondsSinceEpoch,
      'buyerUnreadCount': buyerUnreadCount,
      'sellerUnreadCount': sellerUnreadCount,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] ?? '',
      productId: map['productId'] ?? '',
      buyerId: map['buyerId'] ?? '',
      sellerId: map['sellerId'] ?? '',
      agentId: map['agentId'],
      lastMessage: map['lastMessage'] ?? '',
      lastMessageSenderId:
      map['lastMessageSenderId'] ?? '',
      lastMessageAt: DateTime.fromMillisecondsSinceEpoch(
        map['lastMessageAt'] ?? 0,
      ),
      buyerUnreadCount:
      map['buyerUnreadCount'] ?? 0,
      sellerUnreadCount:
      map['sellerUnreadCount'] ?? 0,
      status: map['status'] ?? 'active',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] ?? 0,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(id: $id)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ChatModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}