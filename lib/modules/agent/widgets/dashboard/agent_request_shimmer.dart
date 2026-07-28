import 'package:flutter/material.dart';

class AgentRequestShimmer extends StatelessWidget {
  const AgentRequestShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, __) => const _ShimmerCard(),
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard();

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .04),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  _box(90, 90, radius: 16),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        _box(double.infinity, 18),
                        const SizedBox(height: 10),
                        _box(120, 16),
                        const SizedBox(height: 10),
                        _box(180, 14),
                        const SizedBox(height: 8),
                        _box(140, 14),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  _circle(),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        _box(80, 12),
                        const SizedBox(height: 8),
                        _box(150, 16),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Expanded(child: _box(double.infinity, 42)),
                  const SizedBox(width: 12),
                  Expanded(child: _box(double.infinity, 42)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _circle() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: _color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _box(
      double width,
      double height, {
        double radius = 8,
      }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Color get _color {
    final value = (_controller.value * 120).toInt();

    return Color.lerp(
      Colors.grey.shade200,
      Colors.grey.shade100,
      value / 120,
    )!;
  }
}