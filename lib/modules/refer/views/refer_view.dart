import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/widgets/custom_widget.dart';
import '../controllers/refer_controller.dart';

class ReferView extends GetView<ReferController> {
  const ReferView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Refer & Earn",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return CustomWidget.buildCircularProgressIndicator();
        }

        return RefreshIndicator(
          onRefresh: () async => controller.onInit(),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
            children: [

              //--------------------------------------------------
              // Hero Banner
              //--------------------------------------------------

              _heroCard(),

              const SizedBox(height: 20),

              //--------------------------------------------------
              // Reward Summary
              //--------------------------------------------------

              _rewardSummaryCard(),

              const SizedBox(height: 20),

              //--------------------------------------------------
              // Reward Uses
              //--------------------------------------------------

              // _rewardCard(),

              // const SizedBox(height: 20),

              //--------------------------------------------------
              // History
              //--------------------------------------------------

              _sectionTitle(
                "Referral History",
                Icons.history_rounded,
              ),

              const SizedBox(height: 10),

              _history(),

              const SizedBox(height: 24),

              //--------------------------------------------------
              // FAQ
              //--------------------------------------------------

              _sectionTitle(
                "Frequently Asked Questions",
                Icons.help_outline_rounded,
              ),

              const SizedBox(height: 10),

              _faq(),

              const SizedBox(height: 40),
            ],
          ),
        );
      }),
    );
  }

  Widget _sectionTitle(
      String title,
      IconData icon,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22,
          color: Theme.of(Get.context!).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _heroCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(Get.context!).colorScheme.primary,
            Theme.of(Get.context!)
                .colorScheme
                .primary
                .withValues(alpha: .82),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(Get.context!)
                .colorScheme
                .primary
                .withValues(alpha: .25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [

            //--------------------------------------------------
            // Top
            //--------------------------------------------------

            Row(
              children: [

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [

                      Text(
                        "🎉 Refer & Earn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      Text(
                        "Invite your friends to TeamoMart.\nBoth of you earn 10 Reward Points.",
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.card_giftcard_rounded,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            //--------------------------------------------------
            // Referral Code
            //--------------------------------------------------

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [

                  Expanded(
                    child: Obx(
                          () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "YOUR REFERRAL CODE",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            controller.referralCode.value,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Material(
                    color: Theme.of(Get.context!)
                        .colorScheme
                        .primary
                        .withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: controller.copyReferralCode,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.copy_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            //--------------------------------------------------
            // Share Button
            //--------------------------------------------------

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor:
                  Theme.of(Get.context!).colorScheme.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: controller.shareReferral,
                icon: const Icon(Icons.share_rounded),
                label: const Text(
                  "Share & Earn",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rewardSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(Get.context!)
                      .colorScheme
                      .primary
                      .withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: Theme.of(Get.context!).colorScheme.primary,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Rewards",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Track your referral performance",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Obx(
                () => Column(
              children: [

                Row(
                  children: [
                    Expanded(
                      child: _summaryItem(
                        Icons.account_balance_wallet_rounded,
                        "Balance",
                        "${controller.rewardBalance.value}",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _summaryItem(
                        Icons.people_alt_rounded,
                        "Invited",
                        "${controller.totalInvitedFriends.value}",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: _summaryItem(
                        Icons.emoji_events_rounded,
                        "Earned",
                        "${controller.totalRewardEarned.value}",
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _summaryItem(
                        Icons.verified_rounded,
                        "Successful",
                        "${controller.successfulReferrals.value}",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(
      IconData icon,
      String title,
      String value,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(Get.context!)
            .colorScheme
            .primary
            .withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            icon,
            size: 22,
            color: Theme.of(Get.context!).colorScheme.primary,
          ),

          const SizedBox(height: 16),

          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _rewardCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.redeem_rounded,
                  color: Colors.amber,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Use Reward Points",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 3),

                    Text(
                      "Redeem your points across TeamoMart",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.15,
            children: [

              _rewardItem(
                Icons.trending_up_rounded,
                "Boost Ads",
                "Promote your listings",
                Colors.orange,
              ),

              _rewardItem(
                Icons.workspace_premium_rounded,
                "Premium",
                "Unlock premium tools",
                Colors.indigo,
              ),

              _rewardItem(
                Icons.discount_rounded,
                "Coupons",
                "Save on purchases",
                Colors.green,
              ),

              _rewardItem(
                Icons.shopping_bag_rounded,
                "Shopping",
                "Use while buying",
                Colors.pink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _rewardItem(
      IconData icon,
      String title,
      String subtitle,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _history() {
    return Obx(
          () => Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const ListTile(
              title: Text(
                "Referral History",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.referralHistory.length,
              itemBuilder: (_, index) {
                final data = controller.referralHistory[index].data();

                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    data['referredUserName'] ?? '',
                  ),
                  subtitle: Text(
                    data['status'] ?? '',
                  ),
                  trailing: Text(
                    "+${data['rewardPoints']}",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _faq() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: const [
          ExpansionTile(
            title: Text("How does referral work?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Share your referral code. When a new user signs up using it, both receive 10 Reward Points.",
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text("When will rewards arrive?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Rewards are added instantly after successful verification.",
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text("Can I change my referral code?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "No. Your referral code is permanent.",
                ),
              )
            ],
          ),
          ExpansionTile(
            title: Text("Can I refer myself?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "No. Self referrals are blocked automatically.",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}