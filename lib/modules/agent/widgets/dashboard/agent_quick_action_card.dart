import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';

class AgentQuickActionCard extends StatelessWidget {
  const AgentQuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.badge,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 108,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                        AppColors.primary.withOpacity(.1),
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                        size: 26,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight:
                        FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),

                if (badge != null &&
                    badge!.isNotEmpty &&
                    badge != "0")
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: Text(
                        badge!,
                        style:
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}