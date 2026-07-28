import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../models/agent_model.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({
    super.key,
    required this.agent,
    required this.onTap,
  });

  final AgentModel agent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
        side: BorderSide(
          color: Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        borderRadius:
        BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage:
                agent.profileImage.isNotEmpty
                    ? NetworkImage(
                  agent.profileImage,
                )
                    : null,
                child: agent.profileImage.isEmpty
                    ? const Icon(
                  Icons.person,
                )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            agent.agentName,
                            style:
                            const TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      agent.experience,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      agent.operatingAreas.isEmpty
                          ? "-"
                          : "${agent.operatingAreas.first.cities}, ${agent.operatingAreas.first.state}",
                      style: TextStyle(
                        color:
                        Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: agent.languages
                          .take(3)
                          .map(
                            (e) => Chip(
                          backgroundColor:
                          AppColors.primary
                              .withOpacity(
                              .08),
                          label: Text(e),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}