/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/location_controller.dart';
import '../models/state_model.dart';

class StateDropdown extends GetView<LocationController> {
  const StateDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButtonFormField<StateModel>(
        value: controller.selectedState.value,

        isExpanded: true,

        decoration: InputDecoration(
          labelText: "State *",
          hintText: "Select State",
          prefixIcon: const Icon(Icons.map_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        items: controller.states
            .map(
              (state) => DropdownMenuItem<StateModel>(
            value: state,
            child: Text(
              state.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),

        onChanged: controller.states.isEmpty
            ? null
            : (StateModel? state) {
          if (state != null) {
            controller.selectState(state);
          }
        },
      );
    });
  }
}*/
