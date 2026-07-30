import 'package:cloud_firestore/cloud_firestore.dart';

class AgentListingModel {
  final String id;

  final String agentId;

  final String agentProductId;

  final String requestId;

  final String originalProductId;

  final String dealStatus;

  final String sellingNotes;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  const AgentListingModel({
    required this.id,
    required this.agentId,
    required this.agentProductId,
    required this.requestId,
    required this.originalProductId,
    required this.dealStatus,
    required this.sellingNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isAvailable => dealStatus == "available";

  bool get isCompleted => dealStatus == "completed";

  factory AgentListingModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return AgentListingModel(
      id: doc.id,
      agentId: data['agentId'],
      agentProductId: data['agentProductId'],
      requestId: data["requestId"] ?? "",
      originalProductId: data["originalProductId"] ?? "",
      dealStatus: data["dealStatus"] ?? "available",
      sellingNotes: data["sellingNotes"] ?? "",
      createdAt: (data["createdAt"] as Timestamp?)?.toDate(),
      updatedAt: (data["updatedAt"] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "agentId": agentId,
      "agentProductId": agentProductId,
      "requestId": requestId,
      "originalProductId": originalProductId,
      "dealStatus": dealStatus,
      "sellingNotes": sellingNotes,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  AgentListingModel copyWith({
    String? status,
    String? dealStatus,
    int? viewCount,
    int? shareCount,
    int? enquiryCount,
    int? chatCount,
  }) {
    return AgentListingModel(
      id: id,
      agentId: agentId,
      agentProductId: agentProductId,
      requestId: requestId,
      originalProductId: originalProductId,
      dealStatus: dealStatus ?? this.dealStatus,
      sellingNotes: sellingNotes,
      createdAt: createdAt,
      updatedAt: updatedAt,);
  }
}