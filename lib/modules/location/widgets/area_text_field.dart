import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';

class AreaTextField extends GetView<LocationController> {
  const AreaTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.areaController,
      textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        labelText: "Area / Locality",
        hintText: "Example: Harmu, Ashok Nagar",
        helperText: "Optional",
        prefixIcon: const Icon(
          Icons.place_outlined,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      onChanged: controller.setArea,
    );
  }
}