import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:flutter/material.dart';

class FeedbackSkeleton extends StatefulWidget {
  const FeedbackSkeleton({super.key, this.width = 80, this.height = 16});

  final double width;
  final double height;

  @override
  State<FeedbackSkeleton> createState() => _FeedbackSkeletonState();
}

class _FeedbackSkeletonState extends State<FeedbackSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: colors.feedbackSkeleton,
          ),
        );
      },
    );
  }
}
