import 'package:flutter/material.dart';

class LinearGradeProgress extends StatelessWidget {
  final double currentGrade;
  final double totalGrade;
  final List<GradeSegment>? segments;
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final bool animate;
  final Duration animationDuration;
  final bool showLabel;
  final TextStyle? labelStyle;
  final Color? backgroundColor;

  const LinearGradeProgress({
    super.key,
    required this.currentGrade,
    this.totalGrade = 30,
    this.segments,
    this.height = 8,
    this.width = 200,
    this.borderRadius,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.showLabel = false,
    this.labelStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (showLabel) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildProgressBar(),
          const SizedBox(height: 4),
          Text(
            '${currentGrade.toInt()}/${totalGrade.toInt()}',
            style: labelStyle ??
                const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
          ),
        ],
      );
    }
    return _buildProgressBar();
  }

  Widget _buildProgressBar() {
    return SizedBox(
      width: width,
      height: height,
      child: animate
          ? AnimatedLinearProgress(
              currentGrade: currentGrade,
              totalGrade: totalGrade,
              segments: segments,
              height: height,
              width: width,
              borderRadius: borderRadius,
              duration: animationDuration,
              backgroundColor: backgroundColor,
            )
          : _buildProgress(currentGrade / totalGrade),
    );
  }

  Widget _buildProgress(double progress) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      child: segments != null && segments!.isNotEmpty
          ? _buildSegmentedProgress(progress)
          : _buildSingleProgress(progress),
    );
  }

  Widget _buildSingleProgress(double progress) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: backgroundColor ?? const Color(0xFFE8E0F0),
      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF5E4B8A)),
      minHeight: height,
    );
  }

  Widget _buildSegmentedProgress(double progress) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          color: backgroundColor ?? const Color(0xFFE8E0F0),
        ),
        Row(
          children: segments!.map((segment) {
            final segmentWidth = (segment.value / totalGrade) * width;
            return Container(
              width: segmentWidth,
              height: height,
              color: segment.color,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AnimatedLinearProgress extends StatefulWidget {
  final double currentGrade;
  final double totalGrade;
  final List<GradeSegment>? segments;
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final Duration duration;
  final Color? backgroundColor;

  const AnimatedLinearProgress({
    Key? key,
    required this.currentGrade,
    required this.totalGrade,
    this.segments,
    required this.height,
    required this.width,
    this.borderRadius,
    required this.duration,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<AnimatedLinearProgress> createState() => _AnimatedLinearProgressState();
}

class _AnimatedLinearProgressState extends State<AnimatedLinearProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.currentGrade / widget.totalGrade,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedLinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentGrade != widget.currentGrade ||
        oldWidget.totalGrade != widget.totalGrade) {
      _animation = Tween<double>(
        begin: oldWidget.currentGrade / oldWidget.totalGrade,
        end: widget.currentGrade / widget.totalGrade,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOutCubic,
        ),
      );
      _controller.forward(from: 0);
    }
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
        return ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.height / 2),
          child: widget.segments != null && widget.segments!.isNotEmpty
              ? _buildSegmentedProgress()
              : _buildSingleProgress(),
        );
      },
    );
  }

  Widget _buildSingleProgress() {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          color: widget.backgroundColor ?? const Color(0xFFE8E0F0),
        ),
        Container(
          width: widget.width * _animation.value,
          height: widget.height,
          color: const Color(0xFF5E4B8A),
        ),
      ],
    );
  }

  Widget _buildSegmentedProgress() {
    final totalValue = widget.segments!.fold(0.0, (sum, seg) => sum + seg.value);
    double currentPosition = 0;

    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          color: widget.backgroundColor ?? const Color(0xFFE8E0F0),
        ),
        Row(
          children: widget.segments!.map((segment) {
            final segmentWidth = (segment.value / totalValue) * widget.width;
            final segmentProgress = _animation.value * widget.width;
            
            double visibleWidth;
            if (currentPosition >= segmentProgress) {
              visibleWidth = 0;
            } else if (currentPosition + segmentWidth <= segmentProgress) {
              visibleWidth = segmentWidth;
            } else {
              visibleWidth = segmentProgress - currentPosition;
            }
            
            currentPosition += segmentWidth;
            
            return Container(
              width: visibleWidth,
              height: widget.height,
              color: segment.color,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class GradeSegment {
  final double value;
  final Color color;
  final String? label;

  GradeSegment({
    required this.value,
    required this.color,
    this.label,
  });
}
