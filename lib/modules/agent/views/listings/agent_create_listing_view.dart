import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/utils/custom_alert.dart';
import '../../controllers/agent_create_listing_controller.dart';

class AgentCreateListingView
    extends GetView<AgentCreateListingController> {
  const AgentCreateListingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        title: const Text("Create Agent Listing"),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            /// Images

            SizedBox(
              height: 110,
              child: Obx(
                    () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.images.length,
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
                  itemBuilder: (_, index) {
                    return ClipRRect(
                      borderRadius:
                      BorderRadius.circular(16),
                      child: Image.network(
                        controller.images[index],
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                            Container(
                              width: 110,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.image,
                              ),
                            ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Listing Details",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller:
              controller.titleController,
              textInputAction:
              TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Listing Title",
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Title is required";
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller:
              controller.descriptionController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "Description",
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return "Description is required";
                }

                return null;
              },
            ),

            const SizedBox(height: 18),

            TextFormField(
              controller:
              controller
                  .sellingNotesController,
              minLines: 4,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText:
                "Selling Notes (Visible only to buyers)",
                alignLabelWithHint: true,
                hintText:
                "Mention negotiation points, delivery, urgency, warranty etc.",
              ),
            ),

            const SizedBox(height: 28),

            Container(
              padding:
              const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Original Product",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _InfoTile(
                    title: "Product ID",
                    value: controller
                        .promotion[
                    "productId"],
                  ),

                  _InfoTile(
                    title: "Seller",
                    value: controller
                        .promotion[
                    "sellerName"],
                  ),

                  _InfoTile(
                    title: "Price",
                    value:
                    "₹${controller.promotion["productPrice"]}",
                  ),

                  _InfoTile(
                    title: "Commission",
                    value:
                    "${controller.promotion["commissionValue"]} ${controller.promotion["commissionType"]}",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Obx(
                  () => FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor:
                  AppColors.primary,
                  minimumSize:
                  const Size.fromHeight(54),
                ),
                onPressed:
                controller.isSaving.value
                    ? null
                    : () async {
                  CustomAlert.loadAlert("Saving...");

                  try {
                    await controller.createListing();

                    CustomAlert.dismissAlert();
                    CustomAlert.successAlert(title: "Listing Created", "Your agent listing is ready.");
                  } catch (e) {
                    CustomAlert.dismissAlert();
                    CustomAlert.errorAlert(title: "Failed",e.toString());
                  }
                },
                child:
                controller.isSaving.value
                    ? const SizedBox(
                  height: 22,
                  width: 22,
                  child:
                  CircularProgressIndicator(
                    strokeWidth: 2,
                    color:
                    Colors.white,
                  ),
                )
                    : const Text(
                  "Create Listing",
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
  });

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [

          SizedBox(
            width: 110,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value?.toString() ?? "-",
              style: const TextStyle(
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}