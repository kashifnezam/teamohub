import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'My Profile',
      'My Listings',
      'Saved Items',
      'Orders',
      'Payments',
      'Settings',
      'Logout',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF101828),
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(color: Color(0xFFEAECEF)),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              items[index],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
          );
        },
      ),
    );
  }
}