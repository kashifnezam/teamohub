import 'package:flutter/material.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      {'name': 'Aarav', 'msg': 'Is the sofa still available?', 'time': '2m'},
      {'name': 'Rohan', 'msg': 'Can you lower the price?', 'time': '10m'},
      {'name': 'Ishita', 'msg': 'Please share more photos.', 'time': '1h'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF101828),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const Divider(color: Color(0xFFEAECEF)),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFEAF2FF),
              child: Text(
                chat['name']![0],
                style: const TextStyle(
                  color: Color(0xFF2F6BFF),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              chat['name']!,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(chat['msg']!),
            trailing: Text(
              chat['time']!,
              style: const TextStyle(color: Color(0xFF667085)),
            ),
          );
        },
      ),
    );
  }
}