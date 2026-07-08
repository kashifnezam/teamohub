import 'package:flutter/material.dart';

class ProfileProgressCard extends StatelessWidget {
  final int percentage;

  const ProfileProgressCard({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Complete Your Profile",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Verified profiles receive more views and sell faster.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 18),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: Colors.white24,
              valueColor:
              const AlwaysStoppedAnimation(Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "$percentage% Completed",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 18),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.indigo,
            ),
            onPressed: () {},
            child: const Text("Complete Now"),
          ),

        ],
      ),
    );
  }
}