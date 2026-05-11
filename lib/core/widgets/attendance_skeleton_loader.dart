import 'package:flutter/material.dart';
import 'package:mobile_flutter/core/theme/app_theme.dart';

class AttendanceSkeletonLoader extends StatelessWidget {
  const AttendanceSkeletonLoader({super.key, this.isStaff = false});

  final bool isStaff;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _SkeletonBox(
          width: double.infinity,
          height: 60,
          borderRadius: AppRadius.md,
        ),
        const SizedBox(height: AppSpacing.md),
        if (isStaff) ...[
          _SkeletonBox(
            width: double.infinity,
            height: 80,
            borderRadius: AppRadius.md,
          ),
          const SizedBox(height: AppSpacing.md),
          _SkeletonBox(
            width: double.infinity,
            height: 200,
            borderRadius: AppRadius.md,
          ),
          const SizedBox(height: AppSpacing.md),
          _SkeletonBox(
            width: double.infinity,
            height: 300,
            borderRadius: AppRadius.md,
          ),
        ] else ...[
          _SkeletonBox(
            width: double.infinity,
            height: 120,
            borderRadius: AppRadius.md,
          ),
          const SizedBox(height: AppSpacing.md),
          _SkeletonBox(
            width: double.infinity,
            height: 200,
            borderRadius: AppRadius.md,
          ),
          const SizedBox(height: AppSpacing.md),
          _SkeletonBox(
            width: double.infinity,
            height: 100,
            borderRadius: AppRadius.md,
          ),
        ],
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const _ShimmerEffect(),
    );
  }
}

class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect();

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ],
              colors: [
                Colors.transparent,
                Theme.of(context).disabledColor.withValues(alpha: 0.2),
                Colors.transparent,
              ],
            ),
          ),
        );
      },
    );
  }
}