import 'package:flutter/material.dart';
import 'dart:math' as math;

class RoundedGradeProgress extends StatelessWidget {
  final double currentGrade;
  final double totalGrade;
  final Color progressColor;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final double strokeWidth;
  final bool animate;
  final Duration animationDuration;
  final TextStyle? textStyle;

  const RoundedGradeProgress({
    super.key,
    required this.currentGrade,
    this.totalGrade = 30,
    this.progressColor = const Color(0xFF5E4B8A),
    this.backgroundColor = const Color(0xFFE8E0F0),
    this.textColor = const Color(0xFF5E4B8A),
    this.size = 60,
    this.strokeWidth = 4,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: animate
          ? AnimatedGradeProgress(
              currentGrade: currentGrade,
              totalGrade: totalGrade,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
              textColor: textColor,
              size: size,
              strokeWidth: strokeWidth,
              duration: animationDuration,
              textStyle: textStyle,
            )
          : _buildProgress(currentGrade / totalGrade),
    );
  }

  Widget _buildProgress(double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(size, size),
          painter: CircularProgressPainter(
            progress: progress,
            progressColor: progressColor,
            backgroundColor: backgroundColor,
            strokeWidth: strokeWidth,
          ),
        ),
        Text(
          '${currentGrade.toInt()}/${totalGrade.toInt()}',
          style: textStyle ??
              TextStyle(
                fontSize: size * 0.21,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
        ),
      ],
    );
  }
}

class AnimatedGradeProgress extends StatefulWidget {
  final double currentGrade;
  final double totalGrade;
  final Color progressColor;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final double strokeWidth;
  final Duration duration;
  final TextStyle? textStyle;

  const AnimatedGradeProgress({
    super.key,
    required this.currentGrade,
    required this.totalGrade,
    required this.progressColor,
    required this.backgroundColor,
    required this.textColor,
    required this.size,
    required this.strokeWidth,
    required this.duration,
    this.textStyle,
  });

  @override
  State<AnimatedGradeProgress> createState() => _AnimatedGradeProgressState();
}

class _AnimatedGradeProgressState extends State<AnimatedGradeProgress>
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
  void didUpdateWidget(AnimatedGradeProgress oldWidget) {
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
        final animatedGrade = _animation.value * widget.totalGrade;
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(widget.size, widget.size),
              painter: CircularProgressPainter(
                progress: _animation.value,
                progressColor: widget.progressColor,
                backgroundColor: widget.backgroundColor,
                strokeWidth: widget.strokeWidth,
              ),
            ),
            Text(
              '${animatedGrade.toInt()}/${widget.totalGrade.toInt()}',
              style: widget.textStyle ??
                  TextStyle(
                    fontSize: widget.size * 0.21,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor,
                  ),
            ),
          ],
        );
      },
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      const startAngle = -math.pi / 2; // Start from top
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
