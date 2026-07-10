import 'dart:convert';

class MessageModel {
  final String id;

  /// Chat Reference
  final String chatId;

  /// Sender & Receiver
  final String senderId;
  final String receiverId;

  /// text | image | video | document | location
  final String type;

  /// Text Message
  final String? text;

  /// File URL (Image, Video, PDF...)
  final String? mediaUrl;

  /// Optional Thumbnail
  final String? thumbnailUrl;

  /// Read Status
  final bool isSeen;
  final DateTime? seenAt;

  /// Optional
  final bool isEdited;
  final bool isDeleted;

  final DateTime createdAt;
  final DateTime updatedAt;

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.receiverId,
    this.type = 'text',
    this.text,
    this.mediaUrl,
    this.thumbnailUrl,
    this.isSeen = false,
    this.seenAt,
    this.isEdited = false,
    this.isDeleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? receiverId,
    String? type,
    String? text,
    String? mediaUrl,
    String? thumbnailUrl,
    bool? isSeen,
    DateTime? seenAt,
    bool? isEdited,
    bool? isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      type: type ?? this.type,
      text: text ?? this.text,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isSeen: isSeen ?? this.isSeen,
      seenAt: seenAt ?? this.seenAt,
      isEdited: isEdited ?? this.isEdited,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'receiverId': receiverId,
      'type': type,
      'text': text,
      'mediaUrl': mediaUrl,
      'thumbnailUrl': thumbnailUrl,
      'isSeen': isSeen,
      'seenAt': seenAt?.millisecondsSinceEpoch,
      'isEdited': isEdited,
      'isDeleted': isDeleted,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      chatId: map['chatId'] ?? '',
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      type: map['type'] ?? 'text',
      text: map['text'],
      mediaUrl: map['mediaUrl'],
      thumbnailUrl: map['thumbnailUrl'],
      isSeen: map['isSeen'] ?? false,
      seenAt: map['seenAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['seenAt'])
          : null,
      isEdited: map['isEdited'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] ?? 0,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] ?? 0,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(id: $id)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MessageModel &&
              runtimeType == other.runtimeType &&
              other.id == id;

  @override
  int get hashCode => id.hashCode;
}