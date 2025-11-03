import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Enhanced circular progress widget that supports different value types
class DynamicCircularProgress extends StatelessWidget {
  final double currentValue;
  final double totalValue;
  final String? label; // Optional label below the value
  final String Function(double current, double total)? valueFormatter;
  final Color progressColor;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final double strokeWidth;
  final bool animate;
  final Duration animationDuration;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;

  const DynamicCircularProgress({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.label,
    this.valueFormatter,
    this.progressColor = const Color(0xFF5E4B8A),
    this.backgroundColor = const Color(0xFFE8E0F0),
    this.textColor = const Color(0xFF5E4B8A),
    this.size = 60,
    this.strokeWidth = 4,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.valueStyle,
    this.labelStyle,
  });

  // Factory constructors for common use cases
  
  /// Creates a time-based progress (e.g., 01:15:00)
  factory DynamicCircularProgress.time({
    Key? key,
    required Duration current,
    required Duration total,
    String? label,
    Color progressColor = const Color(0xFF5E4B8A),
    Color backgroundColor = const Color(0xFFE8E0F0),
    Color textColor = const Color(0xFF5E4B8A),
    double size = 80,
    double strokeWidth = 4,
    bool animate = true,
  }) {
    return DynamicCircularProgress(
      key: key,
      currentValue: current.inSeconds.toDouble(),
      totalValue: total.inSeconds.toDouble(),
      label: label,
      valueFormatter: (curr, total) => _formatDuration(Duration(seconds: curr.toInt())),
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      size: size,
      strokeWidth: strokeWidth,
      animate: animate,
    );
  }

  /// Creates a grade/score progress (e.g., 42/100)
  factory DynamicCircularProgress.grade({
    Key? key,
    required double currentGrade,
    required double totalGrade,
    String? label,
    Color progressColor = const Color(0xFF5E4B8A),
    Color backgroundColor = const Color(0xFFE8E0F0),
    Color textColor = const Color(0xFF5E4B8A),
    double size = 60,
    double strokeWidth = 4,
    bool animate = true,
  }) {
    return DynamicCircularProgress(
      key: key,
      currentValue: currentGrade,
      totalValue: totalGrade,
      label: label,
      valueFormatter: (curr, total) => '${curr.toInt()}',
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      size: size,
      strokeWidth: strokeWidth,
      animate: animate,
    );
  }

  /// Creates a count-based progress (e.g., 8 meetings)
  factory DynamicCircularProgress.count({
    Key? key,
    required int current,
    required int total,
    String? label,
    Color progressColor = const Color(0xFF5E4B8A),
    Color backgroundColor = const Color(0xFFE8E0F0),
    Color textColor = const Color(0xFF5E4B8A),
    double size = 60,
    double strokeWidth = 4,
    bool animate = true,
  }) {
    return DynamicCircularProgress(
      key: key,
      currentValue: current.toDouble(),
      totalValue: total.toDouble(),
      label: label,
      valueFormatter: (curr, total) => '${curr.toInt()}',
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      size: size,
      strokeWidth: strokeWidth,
      animate: animate,
    );
  }

  static String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: animate
          ? AnimatedCircularProgress(
              currentValue: currentValue,
              totalValue: totalValue,
              label: label,
              valueFormatter: valueFormatter,
              progressColor: progressColor,
              backgroundColor: backgroundColor,
              textColor: textColor,
              size: size,
              strokeWidth: strokeWidth,
              duration: animationDuration,
              valueStyle: valueStyle,
              labelStyle: labelStyle,
            )
          : _buildProgress(currentValue / totalValue, currentValue),
    );
  }

  Widget _buildProgress(double progress, double displayValue) {
    final formattedValue = valueFormatter != null
        ? valueFormatter!(displayValue, totalValue)
        : '${displayValue.toInt()}/${totalValue.toInt()}';

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
        Padding(
          padding: EdgeInsets.all(size * 0.15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedValue,
                style: valueStyle ??
                    TextStyle(
                      fontSize: size * 0.14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (label != null) ...[
                SizedBox(height: size * 0.02),
                Text(
                  label!,
                  style: labelStyle ??
                      TextStyle(
                        fontSize: size * 0.12,
                        fontWeight: FontWeight.w500,
                        color: textColor.withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedCircularProgress extends StatefulWidget {
  final double currentValue;
  final double totalValue;
  final String? label;
  final String Function(double current, double total)? valueFormatter;
  final Color progressColor;
  final Color backgroundColor;
  final Color textColor;
  final double size;
  final double strokeWidth;
  final Duration duration;
  final TextStyle? valueStyle;
  final TextStyle? labelStyle;

  const AnimatedCircularProgress({
    super.key,
    required this.currentValue,
    required this.totalValue,
    this.label,
    this.valueFormatter,
    required this.progressColor,
    required this.backgroundColor,
    required this.textColor,
    required this.size,
    required this.strokeWidth,
    required this.duration,
    this.valueStyle,
    this.labelStyle,
  });

  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
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
      end: widget.currentValue / widget.totalValue,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue ||
        oldWidget.totalValue != widget.totalValue) {
      _animation = Tween<double>(
        begin: oldWidget.currentValue / oldWidget.totalValue,
        end: widget.currentValue / widget.totalValue,
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
        final animatedValue = _animation.value * widget.totalValue;
        final formattedValue = widget.valueFormatter != null
            ? widget.valueFormatter!(animatedValue, widget.totalValue)
            : '${animatedValue.toInt()}/${widget.totalValue.toInt()}';

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
            Padding(
              padding: EdgeInsets.all(widget.size * 0.15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    formattedValue,
                    style: widget.valueStyle ??
                        TextStyle(
                          fontSize: widget.size * 0.14,
                          fontWeight: FontWeight.bold,
                          color: widget.textColor,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (widget.label != null) ...[
                    SizedBox(height: widget.size * 0.02),
                    Text(
                      widget.label!,
                      style: widget.labelStyle ??
                          TextStyle(
                            fontSize: widget.size * 0.12,
                            fontWeight: FontWeight.w500,
                            color: widget.textColor.withOpacity(0.7),
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
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

// Example usage demo
class CircularProgressDemo extends StatelessWidget {
  const CircularProgressDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dynamic Circular Progress'),
        backgroundColor: const Color(0xFF5E4B8A),
      ),
      body: Center(
        child: Wrap(
          spacing: 30,
          runSpacing: 30,
          alignment: WrapAlignment.center,
          children: [
            // Time format 1
            DynamicCircularProgress.time(
              current: const Duration(hours: 1, minutes: 15),
              total: const Duration(hours: 2),
              label: 'Time Spent',
              size: 90,
            ),
            
            // Time format 2
            DynamicCircularProgress.time(
              current: const Duration(hours: 1, minutes: 30),
              total: const Duration(hours: 2),
              label: 'Session Time',
              size: 90,
              progressColor: const Color(0xFF6366F1),
              backgroundColor: const Color(0xFFE0E7FF),
              textColor: const Color(0xFF6366F1),
            ),
            
            // Grade/Score
            DynamicCircularProgress.grade(
              currentGrade: 42,
              totalGrade: 100,
              label: 'Score',
              size: 90,
              progressColor: const Color(0xFFEC4899),
              backgroundColor: const Color(0xFFFCE7F3),
              textColor: const Color(0xFFEC4899),
            ),
            
            // Count (meetings)
            DynamicCircularProgress.count(
              current: 8,
              total: 12,
              label: 'Meetings',
              size: 90,
              progressColor: const Color(0xFF10B981),
              backgroundColor: const Color(0xFFD1FAE5),
              textColor: const Color(0xFF10B981),
            ),
            
            // Count (skipped)
            DynamicCircularProgress.count(
              current: 0,
              total: 5,
              label: 'Skipped',
              size: 90,
              progressColor: const Color(0xFFF59E0B),
              backgroundColor: const Color(0xFFFEF3C7),
              textColor: const Color(0xFFF59E0B),
            ),
            
            // Custom formatter (percentage)
            DynamicCircularProgress(
              currentValue: 75,
              totalValue: 100,
              label: 'Complete',
              valueFormatter: (curr, total) => '${curr.toInt()}%',
              size: 90,
              progressColor: const Color(0xFF8B5CF6),
              backgroundColor: const Color(0xFFEDE9FE),
              textColor: const Color(0xFF8B5CF6),
            ),
          ],
        ),
      ),
    );
  }
}