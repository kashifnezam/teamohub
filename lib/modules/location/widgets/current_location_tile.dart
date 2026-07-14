import 'package:flutter/material.dart';

class CurrentLocationTile extends StatelessWidget {
  final VoidCallback onTap;

  const CurrentLocationTile({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.my_location,
                  color: Colors.blue,
                ),
              ),
              title: const Text(
                "Use Current Location",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
            ),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}