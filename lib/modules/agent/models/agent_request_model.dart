import 'package:cloud_firestore/cloud_firestore.dart';

class AgentRequestModel {
  final String id;
  final String productId;

  final String agentId;

  final String userId;
  final String userName;
  final String userImage;

  final String status;
  final String? chatId;

  final DateTime? createdAt;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final DateTime? updatedAt;

  const AgentRequestModel({
    required this.id,
    required this.productId,
    required this.agentId,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.status,
    this.chatId,
    this.createdAt,
    this.acceptedAt,
    this.completedAt,
    this.updatedAt,
  });

  factory AgentRequestModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc,
      ) {
    final data = doc.data()!;

    return AgentRequestModel(
      id: doc.id,
      productId: data['productId'] ?? '',
      agentId: data['agentId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      userImage: data['userImage'] ?? '',
      status: data['status'] ?? 'pending',
      chatId: data['chatId'],
      createdAt: _toDate(data['createdAt']),
      acceptedAt: _toDate(data['acceptedAt']),
      completedAt: _toDate(data['completedAt']),
      updatedAt: _toDate(data['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productId': productId,
      'agentId': agentId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'status': status,
      'chatId': chatId,
      'createdAt': createdAt == null
          ? null
          : Timestamp.fromDate(createdAt!),
      'acceptedAt': acceptedAt == null
          ? null
          : Timestamp.fromDate(acceptedAt!),
      'completedAt': completedAt == null
          ? null
          : Timestamp.fromDate(completedAt!),
      'updatedAt': updatedAt == null
          ? null
          : Timestamp.fromDate(updatedAt!),
    };
  }

  AgentRequestModel copyWith({
    String? id,
    String? productId,
    String? agentId,
    String? userId,
    String? userName,
    String? userImage,
    String? status,
    String? chatId,
    DateTime? createdAt,
    DateTime? acceptedAt,
    DateTime? completedAt,
    DateTime? updatedAt,
  }) {
    return AgentRequestModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      agentId: agentId ?? this.agentId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImage: userImage ?? this.userImage,
      status: status ?? this.status,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isPending => status == 'pending';

  bool get isAccepted =>
      status == 'accepted' || status == 'in_progress';

  bool get isCompleted => status == 'completed';

  bool get isRejected => status == 'rejected';

  static DateTime? _toDate(dynamic value) {
    if (value == null) return null;

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return null;
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'agentId': agentId,
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'status': status,
      'chatId': chatId,
      'createdAt': createdAt,
      'acceptedAt': acceptedAt,
      'completedAt': completedAt,
      'updatedAt': updatedAt,
    };
  }
}