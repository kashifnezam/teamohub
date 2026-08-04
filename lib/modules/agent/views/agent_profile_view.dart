import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamomarket/app/utils/offline_data.dart';
import 'package:teamomarket/app/widgets/custom_widget.dart';

import '../../../app/routes/app_routes.dart';
import '../../../app/theme/app_colors.dart';
import '../controllers/agent_profile_controller.dart';

class AgentProfileView extends GetView<AgentProfileController> {
  const AgentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // final bool showHireButton = Get.parameters["showHireButton"] != "false";
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agent Profile"),
      ),
      backgroundColor: const Color(0xffF7F8FC),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        final agent = controller.agent.value!;
        final isMyProfile = agent.uid == userInfo?['id'];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage:
                  agent.profileImage.isNotEmpty
                      ? NetworkImage(
                    agent.profileImage,
                  )
                      : null,
                  child:
                  agent.profileImage.isEmpty
                      ? const Icon(
                    Icons.person,
                    size: 40,
                  )
                      : null,
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  agent.agentName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Chip(
                  avatar: const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 18,
                  ),
                  label:
                  const Text("Verified Agent"),
                ),
              ),

              const SizedBox(height: 24),

              _section(
                "About",
                agent.about,
              ),

              _section(
                "Experience",
                agent.experience,
              ),

              _section(
                "Years of Experience",
                "${agent.yearsOfExperience}",
              ),

              _section(
                "Commission",
                "${agent.commissionType} • ${agent.commissionValue}",
              ),

              const SizedBox(height: 20),

              const Text(
                "Languages",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: agent.languages
                    .map(
                      (e) => Chip(
                    backgroundColor: AppColors.primary.withValues(alpha: .08),
                    label: Text(e),
                  ),
                )
                    .toList(),
              ),

              const SizedBox(height: 24),

              const Text(
                "Service Areas",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...agent.operatingAreas.map(
                    (e) => ListTile(
                  leading: const Icon(
                    Icons.location_on,
                  ),
                      title: Text(e.cities.map((city) => city.name).join(", ")),
                      subtitle: Text(e.state.name),
                ),
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: Icon(
                    isMyProfile ? Icons.edit : Icons.handshake,
                  ),
                  label: Text(
                    isMyProfile ? "Edit Profile" : "Hire Agent",
                  ),
                  onPressed: () => Get.toNamed(
                    isMyProfile ? AppRoutes.agent : AppRoutes.agentHireRequest,
                    arguments: isMyProfile ? null : agent,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _section(
      String title,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(value),
        ],
      ),
    );
  }
}