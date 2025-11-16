import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/images/edge_rounded_images.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/streak_service.dart';
import 'package:ahiaa_web/core/utils/enums/enums.dart';
import 'package:ahiaa_web/core/utils/constants/image_strings.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_bloc/flutter_bloc.dart';

class FireStreakWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color fireColor;
  final Color textColor;
  final String title;
  final String subtitle;
  final double width;
  final double height;
  final bool animate;
  final Duration animationDuration;

  const FireStreakWidget({
    super.key,
    this.backgroundColor = const Color(0xFF6B4FA0),
    this.fireColor = const Color(0xFF4A3470),
    this.textColor = Colors.white,
    this.title = 'Day Streak',
    this.subtitle = "Keep the streak going - don't break it.",
    this.width = 160,
    this.height = 100,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    final examCubit = context.read<ExamCubit>();

    return BlocBuilder<ExamCubit, ExamState>(
      builder: (context, state) {
        // Check if we have exam sessions
        final hasExamSessions = state.maybeWhen(
          orElse: () => false,
          hasData: (_, __, examSessions, ___) => examSessions.isNotEmpty,
          completed: (examSessions, _) => examSessions.isNotEmpty,
        );

        // If no sessions, show "no streak" immediately
        if (!hasExamSessions) {
          return _buildStreakCard(
            hasStreak: false,
            streakDays: 0,
          );
        }

        // If we have sessions, fetch streak data
        return FutureBuilder<StreakData>(
          future: examCubit.getStreakData(),
          builder: (context, snapshot) {
            // While loading, show the card with current state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildStreakCard(
                hasStreak: false,
                streakDays: 0,
                isLoading: true,
              );
            }

            // If error, show no streak
            if (snapshot.hasError) {
              print('Error loading streak data: ${snapshot.error}');
              return _buildStreakCard(
                hasStreak: false,
                streakDays: 0,
              );
            }

            // If we have data, show the streak
            if (snapshot.hasData) {
              final streakData = snapshot.data!;
              final hasStreak = streakData.currentStreak > 0;

              return _buildStreakCard(
                hasStreak: hasStreak,
                streakDays: streakData.currentStreak,
              );
            }

            // Fallback
            return _buildStreakCard(
              hasStreak: false,
              streakDays: 0,
            );
          },
        );
      },
    );
  }

  Widget _buildStreakCard({
    required bool hasStreak,
    required int streakDays,
    bool isLoading = false,
  }) {
    final displayColor = hasStreak
        ? backgroundColor.withValues(alpha: 0.9)
        : const Color(0xFFD1C4D9);
    final displayFireColor = hasStreak ? fireColor : const Color(0xFFA8A8A8);
    final displayTextColor = hasStreak ? textColor : const Color(0xFF888888);

    return TRoundedContainer(
      width: 178,
      height: 128,
      backgroundColor: displayColor,
      padding: const EdgeInsets.all(0),
      radius: 12,
      child: Stack(
        children: [
          // Fire shape in background (active streak)
          if (hasStreak) ...[
            const Positioned(
              right: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sfb,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: -10,
              bottom: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sfs,
                width: 90,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],

          // Inactive fire shape (no streak)
          if (!hasStreak) ...[
            const Positioned(
              right: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sdb,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: -10,
              bottom: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sds,
                width: 90,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],

          // Content
          Positioned(
            left: 15,
            top: 15,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Loading indicator
                    if (isLoading)
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(displayTextColor),
                        ),
                      )
                    else
                      Text(
                        hasStreak ? '$streakDays' : '00',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: displayTextColor,
                          height: 1,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      hasStreak ? title : 'No streak yet',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: displayTextColor,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      hasStreak
                          ? subtitle
                          : 'Try a 10-minute drill to start one',
                      style: TextStyle(
                        fontSize: 6,
                        color:
                            displayTextColor.withOpacity(hasStreak ? 0.8 : 0.7),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ALTERNATIVE: Optimized Version with Caching
// ============================================================================

/// Optimized version that caches streak data to avoid repeated fetches
class FireStreakWidgetOptimized extends StatefulWidget {
  final Color backgroundColor;
  final Color fireColor;
  final Color textColor;
  final String title;
  final String subtitle;

  const FireStreakWidgetOptimized({
    super.key,
    this.backgroundColor = const Color(0xFF6B4FA0),
    this.fireColor = const Color(0xFF4A3470),
    this.textColor = Colors.white,
    this.title = 'Day Streak',
    this.subtitle = "Keep the streak going - don't break it.",
  });

  @override
  State<FireStreakWidgetOptimized> createState() =>
      _FireStreakWidgetOptimizedState();
}

class _FireStreakWidgetOptimizedState extends State<FireStreakWidgetOptimized> {
  StreakData? _cachedStreakData;
  bool _isLoading = true;
  final examCubit = getIt<ExamCubit>();

  @override
  void initState() {
    super.initState();
    _loadStreakData();
  }

  Future<void> _loadStreakData() async {
    try {
      final streakData = await examCubit.getStreakData();

      if (mounted) {
        setState(() {
          _cachedStreakData = streakData;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading streak data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        // Refresh streak data when exam is completed
        state.maybeWhen(
          completed: (_, __) => _loadStreakData(),
          orElse: () {},
        );
      },
      child: _buildStreakCard(),
    );
  }

  Widget _buildStreakCard() {
    final hasStreak = (_cachedStreakData?.currentStreak ?? 0) > 0;
    final streakDays = _cachedStreakData?.currentStreak ?? 0;

    final displayColor = hasStreak
        ? widget.backgroundColor.withValues(alpha: 0.9)
        : const Color(0xFFD1C4D9);
    final displayTextColor =
        hasStreak ? widget.textColor : const Color(0xFF888888);

    return TRoundedContainer(
      width: 178,
      height: 128,
      backgroundColor: displayColor,
      padding: const EdgeInsets.all(0),
      radius: 12,
      child: Stack(
        children: [
          // Background images
          if (hasStreak) ...[
            const Positioned(
              right: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sfb,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: -10,
              bottom: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sfs,
                width: 90,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],
          if (!hasStreak) ...[
            const Positioned(
              right: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sdb,
                width: 100,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: -10,
              bottom: 0,
              child: PRoundedImage(
                imageType: ImagesType.asset,
                image: PImages.sds,
                width: 90,
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
          ],

          // Content
          Positioned(
            left: 15,
            top: 15,
            child: SizedBox(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isLoading)
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(displayTextColor),
                      ),
                    )
                  else
                    Text(
                      hasStreak ? '$streakDays' : '00',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: displayTextColor,
                        height: 1,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    hasStreak ? widget.title : 'No streak yet',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: displayTextColor,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    hasStreak
                        ? widget.subtitle
                        : 'Try a 10-minute drill to start one',
                    style: TextStyle(
                      fontSize: 6,
                      color:
                          displayTextColor.withOpacity(hasStreak ? 0.8 : 0.7),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FireShape extends StatelessWidget {
  final Color color;
  final double size;

  const FireShape({
    super.key,
    required this.color,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: FirePainter(color: color),
    );
  }
}

class AnimatedFireShape extends StatefulWidget {
  final Color color;
  final double size;
  final bool isActive;
  final Duration duration;

  const AnimatedFireShape({
    super.key,
    required this.color,
    this.size = 80,
    this.isActive = true,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  State<AnimatedFireShape> createState() => _AnimatedFireShapeState();
}

class _AnimatedFireShapeState extends State<AnimatedFireShape>
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

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isActive) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedFireShape oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
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
        return CustomPaint(
          size: Size(widget.size, widget.size),
          painter: FirePainter(
            color: widget.color,
            animationValue: _animation.value,
          ),
        );
      },
    );
  }
}

class FirePainter extends CustomPainter {
  final Color color;
  final double animationValue;

  FirePainter({
    required this.color,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Animation offset for flickering effect
    final flicker = animationValue * 3;

    // Start from bottom left
    path.moveTo(w * 0.3, h);

    // Left side of flame (curved inward)
    path.quadraticBezierTo(
      w * 0.15,
      h * 0.75 - flicker,
      w * 0.15,
      h * 0.5,
    );

    // Left peak
    path.quadraticBezierTo(
      w * 0.03,
      h * 0.35 - flicker * 1.5,
      w * 0.4,
      h * 0.3,
    );

    // Top curve (main flame tip)
    path.quadraticBezierTo(
      w * 0.35 + flicker,
      h * 0.01 - flicker * 2,
      w * 0.5,
      h * 0.1,
    );

    // Right side top
    path.quadraticBezierTo(
      w * 0.5,
      h * 0.19 - flicker,
      w * 0.70,
      h * 0.3,
    );

    // Right side middle (inner curve)
    path.quadraticBezierTo(
      w * 0.85,
      h * 0.45,
      w * 0.78,
      h * 0.6 + flicker,
    );

    // Right side bottom
    path.quadraticBezierTo(
      w * 0.85,
      h * 0.8,
      w * 0.7,
      h,
    );

    // Close path to bottom
    path.lineTo(w * 0.3, h);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(FirePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.color != color;
  }
}
