import '../../product/models/product_model.dart';

class AgentClientRequestModel {
  final String id;

  /// Firestore request document
  final Map<String, dynamic> request;

  /// Requested product
  final ProductModel product;

  AgentClientRequestModel({
    required this.id,
    required this.request,
    required this.product,
  });

  //------------------------------------
  // Convenience Getters
  //------------------------------------

  String get requestId => id;

  String get agentId => request["agentId"] ?? "";

  String get userId => request["userId"] ?? "";

  String get userName => request["userName"] ?? "";

  String get userImage => request["userImage"] ?? "";

  String get status => request["status"] ?? "pending";

  String get productId => request["productId"] ?? "";

  String get chatId => request["chatId"] ?? "";

  String get rejectedReason =>
      request["rejectedReason"] ?? "";

  DateTime? get createdAt {
    final value = request["createdAt"];

    if (value == null) return null;

    return value.toDate();
  }

  DateTime? get updatedAt {
    final value = request["updatedAt"];

    if (value == null) return null;

    return value.toDate();
  }

  DateTime? get acceptedAt {
    final value = request["acceptedAt"];

    if (value == null) return null;

    return value.toDate();
  }

  DateTime? get completedAt {
    final value = request["completedAt"];

    if (value == null) return null;

    return value.toDate();
  }

  bool get isPending => status == "pending";

  bool get isAccepted =>
      status == "accepted" ||
          status == "in_progress";

  bool get isCompleted =>
      status == "completed";

  bool get isRejected =>
      status == "rejected";
}