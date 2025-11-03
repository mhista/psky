import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get_connect/http/src/utils/utils.dart';

class ScoreGaugeWidget extends StatelessWidget {
  final double totalAverage;
  final List<SubjectScore>? subjects;
  final bool isExpanded;

  const ScoreGaugeWidget({
    super.key,
    required this.totalAverage,
    this.subjects,
    this.isExpanded = false
  });

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      height: 128,
      width: 178,
      padding: const EdgeInsets.all(10),
      backgroundColor: PColors.primary5.withValues(alpha:0.2),
      // decoration: BoxDecoration(
      //   color: const Color(0xFFE6E0EC),
      //   borderRadius: BorderRadius.circular(16),
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          SizedBox(
           
            child: CustomPaint(
              painter: GaugePainter(
                percentage: totalAverage,
                subjects: subjects,
                isExpanded: isExpanded
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                        ResponsiveText(
                        '${totalAverage.toInt()}%',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: PColors.primary5,
                        ),
                      ),
                      Text(
                        totalAverage == 0 ? 'No scores yet' : 'Total Average',
                        style:const TextStyle(
                          fontSize: 8,
                          color: PColors.primary5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (subjects != null && subjects!.isNotEmpty) ...[
            // const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: subjects!.map((subject) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 4,
                      decoration: BoxDecoration(
                        color: subject.color,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4)
                      ),
                    ),
                    const SizedBox(width: 6),
                    Row(
                      children: [
                        Text(
                          '${subject.name} - ',
                          style: const TextStyle(
                            fontSize: 6,
                            color: Color.fromARGB(255, 57, 47, 82),
                          ),
                        ),
                        Text(
                          '${subject.score.toInt()}%',
                          style: const TextStyle(
                            fontSize: 6,
                            color: PColors.primary5,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class SubjectScore {
  final String name;
  final double score;
  final Color color;

  SubjectScore({
    required this.name,
    required this.score,
    required this.color,
  });
}





class GaugePainter extends CustomPainter {
  final double percentage;
  final List<SubjectScore>? subjects;
  final bool isExpanded;

  GaugePainter({
    required this.percentage,
    this.subjects,
    this.isExpanded = false
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10);
    final radius = size.width / (isExpanded? 4: 2.9);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = percentage == 0 ? const Color(0xFF6B6B7B) : const Color(0xFFD1C4E0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Draw progress arc(s)
    if (percentage > 0) {
      if (subjects != null && subjects!.isNotEmpty) {
        // Calculate total score to get proportions
        final totalScore = subjects!.fold(0.0, (sum, subject) => sum + subject.score);
        
        // Draw multiple colored arcs for each subject
        double currentAngle = startAngle;
        for (var subject in subjects!) {
          // Calculate sweep angle based on this subject's proportion of total
          final subjectSweepAngle = (subject.score / totalScore) * sweepAngle;
          
          final subjectPaint = Paint()
            ..color = subject.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 20
            ..strokeCap = StrokeCap.butt;

          canvas.drawArc(
            Rect.fromCircle(center: center, radius: radius),
            currentAngle,
            subjectSweepAngle,
            false,
            subjectPaint,
          );
          
          currentAngle += subjectSweepAngle;
        }
      } else {
        // Draw single colored arc
        final progressSweepAngle = (percentage / 100) * sweepAngle;
        
        final progressPaint = Paint()
          ..color = const Color(0xFF5E4B8A)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          progressSweepAngle,
          false,
          progressPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(GaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.subjects != subjects;
  }
}
