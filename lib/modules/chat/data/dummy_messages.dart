import '../models/message_model.dart';

class DummyMessages {
  static List<MessageModel> getMessages(String chatId) {
    switch (chatId) {
      case 'chat_1':
        return _chat1();

      case 'chat_2':
        return _chat2();

      case 'chat_3':
        return _chat3();

      case 'chat_4':
        return _chat4();

      case 'chat_5':
        return _chat5();

      default:
        return [];
    }
  }

  static DateTime _time(int minutesAgo) =>
      DateTime.now().subtract(Duration(minutes: minutesAgo));

  static MessageModel _msg({
    required String id,
    required String chatId,
    required String sender,
    required String receiver,
    required String text,
    int minutesAgo = 0,
    MessageType type = MessageType.text,
    bool seen = true,
  }) {
    return MessageModel(
      id: id,
      chatId: chatId,
      senderId: sender,
      receiverId: receiver,
      type: type,
      message: text,
      isSeen: seen,
      createdAt: _time(minutesAgo),
    );
  }

  // --------------------------------------------------------------------------
  // Chat 1
  // --------------------------------------------------------------------------

  static List<MessageModel> _chat1() => [
    _msg(
        id: '1',
        chatId: 'chat_1',
        sender: 'buyer_1',
        receiver: 'seller_1',
        text: 'Hi, is this available?',
        minutesAgo: 220),

    _msg(
        id: '2',
        chatId: 'chat_1',
        sender: 'seller_1',
        receiver: 'buyer_1',
        text: 'Yes, it is available.',
        minutesAgo: 215),

    _msg(
        id: '3',
        chatId: 'chat_1',
        sender: 'buyer_1',
        receiver: 'seller_1',
        text: 'Any scratches?',
        minutesAgo: 210),

    _msg(
        id: '4',
        chatId: 'chat_1',
        sender: 'seller_1',
        receiver: 'buyer_1',
        text: 'No. Condition is excellent.',
        minutesAgo: 205),

    _msg(
        id: '5',
        chatId: 'chat_1',
        sender: 'buyer_1',
        receiver: 'seller_1',
        text: 'Final price?',
        minutesAgo: 195),

    _msg(
        id: '6',
        chatId: 'chat_1',
        sender: 'seller_1',
        receiver: 'buyer_1',
        text: '₹78,000',
        minutesAgo: 190),

    _msg(
        id: '7',
        chatId: 'chat_1',
        sender: 'buyer_1',
        receiver: 'seller_1',
        text: 'Can I inspect tomorrow?',
        minutesAgo: 170),

    _msg(
        id: '8',
        chatId: 'chat_1',
        sender: 'seller_1',
        receiver: 'buyer_1',
        text: 'Sure.',
        minutesAgo: 160),

    _msg(
        id: '9',
        chatId: 'chat_1',
        sender: 'buyer_1',
        receiver: 'seller_1',
        text: '11 AM works?',
        minutesAgo: 20),

    _msg(
        id: '10',
        chatId: 'chat_1',
        sender: 'seller_1',
        receiver: 'buyer_1',
        text: 'See you tomorrow at 11 AM.',
        minutesAgo: 8,
        seen: false),
  ];

  // --------------------------------------------------------------------------
  // Chat 2
  // --------------------------------------------------------------------------

  static List<MessageModel> _chat2() => [
    _msg(
        id: '1',
        chatId: 'chat_2',
        sender: 'buyer_1',
        receiver: 'seller_2',
        text: 'Is the Activa still available?',
        minutesAgo: 240),

    _msg(
        id: '2',
        chatId: 'chat_2',
        sender: 'seller_2',
        receiver: 'buyer_1',
        text: 'Yes.',
        minutesAgo: 235),

    _msg(
        id: '3',
        chatId: 'chat_2',
        sender: 'buyer_1',
        receiver: 'seller_2',
        text: 'First owner?',
        minutesAgo: 225),

    _msg(
        id: '4',
        chatId: 'chat_2',
        sender: 'seller_2',
        receiver: 'buyer_1',
        text: 'Yes.',
        minutesAgo: 220),

    _msg(
        id: '5',
        chatId: 'chat_2',
        sender: 'seller_2',
        receiver: 'buyer_1',
        text: 'Price is slightly negotiable.',
        minutesAgo: 120),
  ];

  // --------------------------------------------------------------------------
  // Chat 3
  // --------------------------------------------------------------------------

  static List<MessageModel> _chat3() => [
    _msg(
        id: '1',
        chatId: 'chat_3',
        sender: 'buyer_1',
        receiver: 'seller_3',
        text: 'Battery health?',
        minutesAgo: 400),

    _msg(
        id: '2',
        chatId: 'chat_3',
        sender: 'seller_3',
        receiver: 'buyer_1',
        text: '100%',
        minutesAgo: 395),

    _msg(
        id: '3',
        chatId: 'chat_3',
        sender: 'seller_3',
        receiver: 'buyer_1',
        text: 'Warranty is still available.',
        minutesAgo: 360,
        seen: false),
  ];

  // --------------------------------------------------------------------------
  // Chat 4
  // --------------------------------------------------------------------------

  static List<MessageModel> _chat4() => [
    _msg(
        id: '1',
        chatId: 'chat_4',
        sender: 'buyer_1',
        receiver: 'seller_4',
        text: 'Controller included?',
        minutesAgo: 180),

    _msg(
        id: '2',
        chatId: 'chat_4',
        sender: 'seller_4',
        receiver: 'buyer_1',
        text: 'Yes, one controller.',
        minutesAgo: 170),

    _msg(
        id: '3',
        chatId: 'chat_4',
        sender: 'seller_4',
        receiver: 'buyer_1',
        text: 'Can you pick it up today?',
        minutesAgo: 144,
        seen: true),
  ];

  // --------------------------------------------------------------------------
  // Chat 5
  // --------------------------------------------------------------------------

  static List<MessageModel> _chat5() => [
    _msg(
        id: '1',
        chatId: 'chat_5',
        sender: 'buyer_1',
        receiver: 'seller_5',
        text: 'I\'ll take it.',
        minutesAgo: 90),

    _msg(
        id: '2',
        chatId: 'chat_5',
        sender: 'seller_5',
        receiver: 'buyer_1',
        text: 'Great!',
        minutesAgo: 80),

    _msg(
        id: '3',
        chatId: 'chat_5',
        sender: 'buyer_1',
        receiver: 'seller_5',
        text: 'Thank you 😊',
        minutesAgo: 70),
  ];
}