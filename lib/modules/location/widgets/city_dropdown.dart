/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../models/city_model.dart';

class CityDropdown extends GetView<LocationController> {
  const CityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<CityModel>(
        value: controller.selectedCity.value,
        isExpanded: true,

        decoration: InputDecoration(
          labelText: "City *",
          hintText: "Select City",
          prefixIcon: const Icon(Icons.location_city_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        items: controller.cities
            .map(
              (city) => DropdownMenuItem<CityModel>(
            value: city,
            child: Text(
              city.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),

        onChanged: controller.cities.isEmpty
            ? null
            : (CityModel? city) {
          if (city != null) {
            controller.selectCity(city);
          }
        },
      );
    });
  }
}*/
