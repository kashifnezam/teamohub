import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,
  image,
  offer,
  system,
}

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String receiverId;
  final MessageType type;
  final String message;
  final String? image;
  final bool isSeen;
  final DateTime createdAt;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    this.type = MessageType.text,
    required this.message,
    this.image,
    this.isSeen = false,
    required this.createdAt,
  });

  MessageModel copyWith({
    bool? isSeen,
    String? message,
    String? image,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id,
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      type: type,
      message: message ?? this.message,
      image: image ?? this.image,
      isSeen: isSeen ?? this.isSeen,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data() ?? {};

    return MessageModel(
      id: doc.id,
      chatId: data['chatId'] ?? '',
      senderId: data['senderId'] ?? '',
      receiverId: data['receiverId'] ?? '',
      type: MessageType.values.firstWhere(
            (e) => e.name == data['type'],
        orElse: () => MessageType.text,
      ),
      message: data['message'] ?? '',
      image: data['image'],
      isSeen: data['isSeen'] ?? false,
      createdAt:
      (data['createdAt'] as Timestamp?)
          ?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type.name,
      'message': message,
      'image': image,
      'isSeen': isSeen,
      'createdAt': createdAt,
    };
  }

  static MessageType _parseType(dynamic value) {
    return MessageType.values.firstWhere(
          (e) => e.name == value,
      orElse: () => MessageType.text,
    );
  }
}