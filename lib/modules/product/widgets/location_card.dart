import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/routes/app_routes.dart';

import '../controllers/product_controller.dart';

class LocationCard extends GetView<ProductController> {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Obx(() {
          final hasLocation =
              controller.city.value.isNotEmpty;

          return Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              //--------------------------------------
              // Header
              //--------------------------------------

              const Text(
                "Location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Help nearby buyers discover your product.",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 18),

              //--------------------------------------
              // Location Tile
              //--------------------------------------

              InkWell(
                borderRadius:
                BorderRadius.circular(16),
                onTap: () => Get.toNamed(Routes.locationPicker),
                child: AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 250),
                  padding:
                  const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius:
                    BorderRadius.circular(16),
                    border: Border.all(
                      color: controller.locationError.value
                          ? theme.colorScheme.error
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    children: [

                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary
                              .withOpacity(.08),
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: hasLocation
                            ? Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            Text(
                              controller.city.value,
                              style:
                              const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "${controller.state.value}, ${controller.country.value}",
                              style: TextStyle(
                                color: Colors
                                    .grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [

                            const Text(
                              "Select Location",
                              style:
                              TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              "Country, State & City",
                              style: TextStyle(
                                color: Colors
                                    .grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),

              //--------------------------------------
              // Validation
              //--------------------------------------

              if (controller.locationError.value)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 4,
                  ),
                  child: Text(
                    "Please select a location.",
                    style: TextStyle(
                      color:
                      theme.colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 14),

              //--------------------------------------
              // Area
              //--------------------------------------

              TextFormField(
                controller:
                controller.areaController,
                textCapitalization:
                TextCapitalization.words,
                decoration: InputDecoration(
                  labelText:
                  "Area / Locality (Optional)",
                  hintText:
                  "Example: Ashok Nagar",
                  prefixIcon:
                  const Icon(Icons.place_outlined),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              //--------------------------------------
              // Current Location
              //--------------------------------------

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed:
                  controller.useCurrentLocation,
                  icon: const Icon(
                    Icons.my_location,
                    size: 18,
                  ),
                  label: const Text(
                    "Use Current Location",
                  ),
                ),
              ),

              Text(
                "Your exact address won't be shown publicly.",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}