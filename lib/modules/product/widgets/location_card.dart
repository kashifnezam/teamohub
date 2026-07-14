import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../location/models/location_result.dart';
import '../../location/views/location_picker_page.dart';
import '../controllers/product_controller.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductController controller =
    Get.find<ProductController>();

    final theme = Theme.of(context);

    return Obx(() {
      final hasLocation = controller.city.value.isNotEmpty;

      return Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: hasLocation
                    ? theme.colorScheme.outline.withOpacity(.2)
                    : Colors.grey.shade300,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                final LocationResult? result =
                await Get.to<LocationResult>(
                      () => LocationPickerPage(),
                );

                if (result == null) return;

                controller.setLocation(
                  countryValue: result.country.name,
                  stateValue: result.state.name,
                  cityValue: result.city.name,
                  latitudeValue: result.city.latitude,
                  longitudeValue: result.city.longitude,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [

                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius:
                        BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Location",
                            style: theme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight:
                              FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 6),

                          AnimatedSwitcher(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            child: hasLocation
                                ? Text(
                              "${controller.city.value}, ${controller.state.value}",
                              key: const ValueKey(
                                  "selected"),
                              style: theme
                                  .textTheme
                                  .bodyMedium,
                            )
                                : Text(
                              "Tap to select location",
                              key: const ValueKey(
                                  "empty"),
                              style: theme
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color:
                                Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      children: [

                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade600,
                        ),

                        if (hasLocation)
                          Container(
                            margin:
                            const EdgeInsets.only(
                              top: 8,
                            ),
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green
                                  .withOpacity(.12),
                              borderRadius:
                              BorderRadius.circular(
                                  20),
                            ),
                            child: const Text(
                              "Selected",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight:
                                FontWeight.w600,
                                fontSize: 11,
                              ),
                            ),
                          ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          //--------------------------------------
          // Area
          //--------------------------------------
          const SizedBox(height: 12),

          TextFormField(
            controller: controller.areaController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: "Area / Locality (Optional)",
              hintText: "Example: Ashok Nagar",
              prefixIcon: const Icon(Icons.place_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

        ],
      );
    });
  }
}