import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AgentPromotionRequestsView extends StatelessWidget {
  const AgentPromotionRequestsView({
    super.key,
    required this.requests,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> requests;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Promotion Requests"),
      ),
      body: AgentPromotionRequestsBody(
        requests: requests,
      ),
    );
  }
}

class AgentPromotionRequestsBody extends StatelessWidget {
  const AgentPromotionRequestsBody({
    super.key,
    required this.requests,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> requests;

  @override
  Widget build(BuildContext context) {
    if (requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 70,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            const Text(
              "No Promotion Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Promotion requests will appear here.",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final data = requests[index].data();

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(
              color: Color(0xffE8EAF3),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data["image"] ?? "",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.image),
                    ),
              ),
            ),
            title: Text(
              data["title"] ?? "-",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              data["sellerName"] ?? "-",
            ),
            trailing: const Icon(
              Icons.chevron_right_rounded,
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}