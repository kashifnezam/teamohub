import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/agent_controller.dart';

class StatePickerPage extends GetView<AgentController> {
  const StatePickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Select State"),
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),

      body: Obx(() {

        if (controller.loadingStates.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.separated(
          itemCount: controller.states.length,
          separatorBuilder: (_, __) =>
          const Divider(height: 1),
          itemBuilder: (_, index) {

            final state = controller.states[index];

            final alreadySelected =
            controller.operatingAreas.any(
                  (e) => e.state.id == state.id,
            );

            return ListTile(
              title: Text(state.name),

              trailing: alreadySelected
                  ? const Icon(
                Icons.check,
                color: Colors.green,
              )
                  : null,

              enabled: !alreadySelected,

              onTap: alreadySelected
                  ? null
                  : () {
                Get.back(result: state);
              },
            );
          },
        );
      }),
    );
  }
}