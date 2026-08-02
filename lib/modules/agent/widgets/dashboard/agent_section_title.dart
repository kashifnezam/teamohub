import 'package:flutter/material.dart';

class AgentSectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const AgentSectionTitle({
    super.key,
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: -.3,
            ),
          ),
        ),

        if (onViewAll != null)
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onViewAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [

                  Text(
                    "View All",
                    style: TextStyle(
                      color: Color(0xff4F46E5),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(width: 2),

                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: Color(0xff4F46E5),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}