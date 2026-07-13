import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../models/country_model.dart';

class CountryDropdown extends GetView<LocationController> {
  const CountryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<CountryModel>(
        initialValue: controller.selectedCountry.value,

        isExpanded: true,

        decoration: InputDecoration(
          labelText: "Country *",
          hintText: "Select Country",
          prefixIcon: const Icon(Icons.public),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        items: controller.countries
            .map(
              (country) => DropdownMenuItem(
            value: country,
            child: Text(
              country.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),

        onChanged: (CountryModel? country) {
          if (country != null) {
            controller.selectCountry(country);
          }
        },
      );
    });
  }
}