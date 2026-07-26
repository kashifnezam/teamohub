import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/utils/custom_alert.dart';
import '../../controllers/agent_my_listings_controller.dart';

class AgentMyListingsView
    extends GetView<AgentMyListingsController> {
  const AgentMyListingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Listings"),
      ),
      backgroundColor: const Color(0xffF7F8FC),
      body: Obx(() {

        if (controller.isLoading.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        if (controller.listings.isEmpty) {
          return const Center(
            child: Text(
              "No listings available.",
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshListings,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.listings.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 16),
            itemBuilder: (_, index) {

              final doc = controller.listings[index];

              final data = doc.data();

              final List images =
                  data["images"] ?? [];

              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [

                      Row(
                        children: [

                          ClipRRect(
                            borderRadius:
                            BorderRadius.circular(
                                12),
                            child: images.isNotEmpty
                                ? Image.network(
                              images.first,
                              width: 85,
                              height: 85,
                              fit: BoxFit.cover,
                            )
                                : Container(
                              width: 85,
                              height: 85,
                              color: Colors.grey
                                  .shade200,
                              child: const Icon(
                                Icons.image,
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [

                                Text(
                                  data["title"] ?? "",
                                  maxLines: 2,
                                  overflow:
                                  TextOverflow
                                      .ellipsis,
                                  style:
                                  const TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                                const SizedBox(
                                    height: 8),

                                Text(
                                  "Status : ${data["dealStatus"]}",
                                ),

                                Text(
                                  "Views : ${data["viewCount"]}",
                                ),

                                Text(
                                  "Shares : ${data["shareCount"]}",
                                ),

                                Text(
                                  "Chats : ${data["chatCount"]}",
                                ),

                                Text(
                                  "Enquiries : ${data["enquiryCount"]}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        children: [

                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                Icons.share,
                              ),
                              label: const Text(
                                  "Share"),
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes
                                      .agentListingShare,
                                  arguments:
                                  doc.id,
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: OutlinedButton.icon(
                              icon: const Icon(
                                  Icons.edit),
                              label: const Text(
                                  "Edit"),
                              onPressed: () {
                                Get.toNamed(
                                  AppRoutes
                                      .agentCreateListing,
                                  arguments:
                                  data,
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [

                          Expanded(
                            child: FilledButton(
                              onPressed: () async {

                                final confirm =
                                await CustomAlert.confirmAlert(
                                  title:
                                  "Complete Deal",
                                  "Mark this listing as sold?",
                                );

                                if (confirm ==
                                    true) {
                                  controller.markSold(
                                    doc.id,
                                  );
                                }
                              },
                              child: const Text(
                                  "Mark Sold"),
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: FilledButton(
                              style:
                              FilledButton
                                  .styleFrom(
                                backgroundColor:
                                Colors.red,
                              ),
                              onPressed: () async {

                                final confirm =
                                await CustomAlert.confirmAlert(
                                  title: "Deactivate",
                                  "Deactivate this listing?",
                                );

                                if (confirm ==
                                    true) {
                                  controller
                                      .deactivate(
                                    doc.id,
                                  );
                                }
                              },
                              child: const Text(
                                "Deactivate",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}