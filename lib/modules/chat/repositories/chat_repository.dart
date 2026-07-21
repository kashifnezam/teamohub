import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  ChatRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _chats =>
      _firestore.collection('chats');

  String get _currentUserId => _auth.currentUser!.uid;

  //--------------------------------------------------------------------------
  // Create or Get Existing Chat
  //--------------------------------------------------------------------------

  Future<String> getOrCreateChat({
    required String sellerId,
    required double productPrice,
    required String sellerName,
    String? sellerPhoto,
    required String buyerId,
    required String buyerName,
    required String buyerPhoto,
    required String productId,
    required String productTitle,
    required String productImage,
  }) async {
    final ids = [buyerId, sellerId]..sort();

    final chatId = '${productId}_${ids.first}_${ids.last}';

    final docRef = _chats.doc(chatId);

    final doc = await docRef.get();

    if (doc.exists) {
      return chatId;
    }

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (snapshot.exists) return;

      final chat = ChatModel(
        id: chatId,
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

        lastMessage: '',
        lastMessageType: MessageType.text,
        lastMessageTime: DateTime.now(),

        unreadCount: 0,

        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final data = chat.toMap();

      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      data['lastMessageTime'] = FieldValue.serverTimestamp();

      transaction.set(docRef, data);
      sendMessage(
        chatId: chatId,
        senderId: buyerId,
        receiverId: sellerId,
        text: "I'm interested in your ads",
      );
    });

    return chatId;
  }

  //--------------------------------------------------------------------------
  // Chat List (Realtime)
  //--------------------------------------------------------------------------

  Stream<List<ChatModel>> streamChats() {
    return _chats
        .where('participants', arrayContains: _currentUserId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ChatModel.fromFirestore(
              doc,
              currentUserId: _currentUserId,
            ),
          )          .toList(),
    );
  }

  //---------------------------------------------------------------------------
// Single Chat (Realtime)
//---------------------------------------------------------------------------

  Stream<ChatModel> streamChat(String chatId) {
    return _chats
        .doc(chatId)
        .snapshots()
        .map(
          (doc) => ChatModel.fromFirestore(
        doc,
        currentUserId: _currentUserId,
      ),
    );
  }

  //--------------------------------------------------------------------------
  // Messages (Realtime)
  //--------------------------------------------------------------------------

  Stream<List<MessageModel>> streamMessages(String chatId) {
    return _chats
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
          .map((doc) => MessageModel.fromFirestore(doc))
          .toList(),
    );
  }

  //--------------------------------------------------------------------------
  // Send Message
  //--------------------------------------------------------------------------

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final chatRef = _chats.doc(chatId);
    final messageRef = chatRef.collection('messages').doc();

    final message = MessageModel(
      id: messageRef.id,
      chatId: chatId,
      senderId: senderId,
      receiverId: receiverId,
      type: MessageType.text,
      message: text,
      image: null,
      isSeen: false,
      createdAt: DateTime.now(),
    );

    final data = message.toMap();
    data['createdAt'] = FieldValue.serverTimestamp();

    final batch = _firestore.batch();

    batch.set(messageRef, data);

    batch.update(chatRef, {
      'lastMessage': text,
      'lastMessageType': MessageType.text.name,
      'lastMessageTime': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'unreadCounts.$receiverId': FieldValue.increment(1),
      'unreadCounts.$senderId': 0,
    });

    await batch.commit();
  }

  //--------------------------------------------------------------------------
  // Read Messages
  //--------------------------------------------------------------------------

  Future<void> markMessagesAsRead(String chatId) async {
    final chatRef = _chats.doc(chatId);

    final messages = await chatRef
        .collection('messages')
        .where('receiverId', isEqualTo: _currentUserId)
        .where('isSeen', isEqualTo: false)
        .get();

    if (messages.docs.isEmpty) return;
    final batch = _firestore.batch();

    for (final doc in messages.docs) {
      batch.update(doc.reference, {
        'isSeen': true,
      });
    }

    batch.update(chatRef, {
      'unreadCounts.$_currentUserId': 0,
    });

    await batch.commit();
  }
}