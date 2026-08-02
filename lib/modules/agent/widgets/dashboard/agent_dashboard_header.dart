import 'package:flutter/material.dart';

import '../../models/agent_model.dart';

class AgentDashboardHeader extends StatelessWidget {
  final AgentModel agent;
  final String greeting;

  const AgentDashboardHeader({
    super.key,
    required this.agent,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff4F46E5),
            Color(0xff6D5DF6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff4F46E5).withValues(alpha: .22),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        children: [

          /// Top Row
          Row(
            children: [

              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white24,
                backgroundImage: agent.profileImage.isNotEmpty == true
                    ? NetworkImage(agent.profileImage)
                    : null,
                child: agent.profileImage.isEmpty
                    ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 30,
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
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            agent.agentName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        if (agent.agentStatus == 'verified')
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Icon(
                                  Icons.verified_rounded,
                                  color: Colors.white,
                                  size: 16,
                                ),

                                SizedBox(width: 4),

                                Text(
                                  "Verified",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Colors.white70,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            _serviceArea(agent),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.white24,
              ),
            ),
            child: Row(
              children: [

                Expanded(
                  child: _InfoItem(
                    title: "Status",
                    value: agent.agentStatus.toUpperCase(),
                  ),
                ),

                Container(
                  width: 1,
                  height: 38,
                  color: Colors.white24,
                ),

                Expanded(
                  child: _InfoItem(
                    title: "Areas",
                    value: agent.operatingAreas.length.toString(),
                  ),
                ),

                Container(
                  width: 1,
                  height: 38,
                  color: Colors.white24,
                ),

                Expanded(
                  child: _InfoItem(
                    title: "Role",
                    value: "Agent",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _serviceArea(AgentModel agent) {
    if (agent.operatingAreas.isEmpty) {
      return "No service area";
    }

    final area = agent.operatingAreas.first;

    if (area.cities.isNotEmpty) {
      return "${area.cities.first.name}, ${area.state.name}";
    }

    return area.state.name;
  }
}

class _InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const _InfoItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}