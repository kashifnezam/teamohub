import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/theme/app_colors.dart';
import '../../controllers/agent_listing_share_controller.dart';

class AgentListingShareView
    extends GetView<AgentListingShareController> {
  const AgentListingShareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("Share Listing"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.link,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 20),
                  SelectableText(
                    controller.shareUrl,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: controller.copyLink,
                    icon: const Icon(Icons.copy),
                    label: const Text("Copy Link"),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: controller.shareListing,
                    icon: const Icon(Icons.share),
                    label: const Text("Share"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Important",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "• Customers contacting through this link will contact you directly.",
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Seller contact information is never exposed.",
                  ),
                  SizedBox(height: 8),
                  Text(
                    "• Views and shares are automatically tracked.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}