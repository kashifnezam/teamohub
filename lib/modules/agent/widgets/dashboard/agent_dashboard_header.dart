import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../models/agent_model.dart';

class AgentDashboardHeader extends StatelessWidget {
  const AgentDashboardHeader({
    super.key,
    required this.agent,
    required this.greeting,
  });

  final AgentModel agent;
  final String greeting;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool mobile = constraints.maxWidth < 650;

        if (mobile) {
          return _mobileHeader();
        }

        return _tabletHeader();
      },
    );
  }

  Widget _mobileHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: AppColors.primary.withOpacity(.1),
          backgroundImage: agent.profileImage.isNotEmpty
              ? NetworkImage(agent.profileImage)
              : null,
          child: agent.profileImage.isEmpty
              ? const Icon(
            Icons.person,
            size: 32,
          )
              : null,
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      agent.agentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (agent.verificationStatus == "verified")
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 20,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey.shade600,
                    size: 16,
                  ),

                  const SizedBox(width: 4),

                  Expanded(
                    child: Text(
                      _serviceArea(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabletHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 38,
          backgroundColor: AppColors.primary.withOpacity(.1),
          backgroundImage: agent.profileImage.isNotEmpty
              ? NetworkImage(agent.profileImage)
              : null,
          child: agent.profileImage.isEmpty
              ? const Icon(
            Icons.person,
            size: 38,
          )
              : null,
        ),

        const SizedBox(width: 20),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Flexible(
                    child: Text(
                      agent.agentName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  if (agent.verificationStatus == "verified")
                    const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 22,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.grey.shade600,
                    size: 18,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      _serviceArea(),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _serviceArea() {
    if (agent.operatingAreas.isEmpty) {
      return "-";
    }

    final area = agent.operatingAreas.first;

    if (area.cities.isNotEmpty) {
      return "${area.cities.first.name}, ${area.state.name}";
    }

    return area.state.name;
  }
}