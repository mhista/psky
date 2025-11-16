import 'package:ahiaa_web/core/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/core/common/widgets/texts/fitted_texts.dart';
import 'package:ahiaa_web/core/injectable/injection_container.dart';
import 'package:ahiaa_web/core/services/exam_result_calculator.dart';
import 'package:ahiaa_web/core/services/subject_service.dart';
import 'package:ahiaa_web/core/utils/constants/colors.dart';
import 'package:ahiaa_web/features/practice_exam/presentation/cubits/cubit/exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;

class ScoreGaugeWidget extends StatefulWidget {
  
  final bool isExpanded;

  const ScoreGaugeWidget({
    super.key,
    
    this.isExpanded = false,
  });

  @override
  State<ScoreGaugeWidget> createState() => _ScoreGaugeWidgetState();
}

class _ScoreGaugeWidgetState extends State<ScoreGaugeWidget> {
  bool _isLoading = true;
  AggregateExamResult? aggregate;
  List<ExamResult>? bestScores;
  List<(String, double)>? scores;
    final examCubit = getIt<ExamCubit>();


  @override
  void initState() {
    super.initState();
    _loadScoreGauge();
  }

  Future<void> _loadScoreGauge() async {
    final repo = getIt<SubjectRepository>();

    aggregate = examCubit.calculateAggregateResults();
    
    if (aggregate == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Sort by percentage descending
    aggregate!.individualResults.sort(
      (a, b) => b.score.percentage.compareTo(a.score.percentage)
    );

    // ✅ NEW: Group by subject and keep highest score for each
    final Map<String, ExamResult> subjectBestResults = {};
    
    for (final result in aggregate!.individualResults) {
      final subjectId = result.examSession.subjectId;
      final subjectName = repo.getSubjectById(subjectId)?.name ?? '';
      
      // Skip if no subject name
      if (subjectName.isEmpty) continue;
      
      // If subject not seen before, or this result is better
      if (!subjectBestResults.containsKey(subjectName) ||
          result.score.percentage > 
          subjectBestResults[subjectName]!.score.percentage) {
        subjectBestResults[subjectName] = result;
      }
    }

    // ✅ Convert to list and take top 4 unique subjects
    bestScores = subjectBestResults.values.toList()
      ..sort((a, b) => b.score.percentage.compareTo(a.score.percentage));
    
    bestScores = bestScores!.take(4).toList();

    // ✅ Create scores list with unique subjects and shortened names
    scores = bestScores!
        .map((b) {
          final fullName = repo.getSubjectById(b.examSession.subjectId)?.name ?? '';
          final shortName = _shortenSubjectName(fullName);
          return (shortName, b.performanceMetrics.accuracy);
        })
        .toList();

    setState(() {
      _isLoading = false;
    });
  }

  /// ✅ NEW: Shorten subject names by removing last word
  String _shortenSubjectName(String fullName) {
    if (fullName.isEmpty) return fullName;
    
    // Split by space
    final words = fullName.trim().split(' ');
    
    // If only one word, return as is
    if (words.length == 1) return fullName;
    
    // Return all words except the last one
    return words.sublist(0, words.length - 1).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExamCubit, ExamState>(
      bloc: examCubit,
      listener: (context, state) {
        // Refresh streak data when exam is completed
        state.maybeWhen(
          hasData: (_, __,___,____) => _loadScoreGauge(),
          completed: (_, __) => _loadScoreGauge(),

          orElse: () {},
        );
      },
      child: _buildScoreGauge(),
    );
  }

  TRoundedContainer _buildScoreGauge() {
    final colors = [
      PColors.primary5,
      PColors.primary2,
      PColors.darkerGrey,
      PColors.white
    ];

    // ✅ Build subject scores from unique scores
    final subjects = scores?.asMap().entries.map((entry) {
      final index = entry.key;
      final score = entry.value;
      
      return SubjectScore(
        name: score.$1,
        score: score.$2,
        color: colors[index % colors.length], // Use modulo to prevent index out of bounds
      );
    }).toList();

    final totalAverage = aggregate?.averageAccuracy ?? 0.0;

    return TRoundedContainer(
      height: 128,
      width: 178,
      padding: const EdgeInsets.all(10),
      backgroundColor: PColors.primary5.withValues(alpha: 0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          SizedBox(
            child: CustomPaint(
              painter: GaugePainter(
                percentage: totalAverage,
                subjects: subjects,
                isExpanded: widget.isExpanded,
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
                        _isLoading || totalAverage == 0 
                            ? 'No scores yet' 
                            : 'Total Average',
                        style: const TextStyle(
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
                        borderRadius: BorderRadius.circular(4),
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
                            fontWeight: FontWeight.w800,
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectScore &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class GaugePainter extends CustomPainter {
  final double percentage;
  final List<SubjectScore>? subjects;
  final bool isExpanded;

  GaugePainter({
    required this.percentage,
    this.subjects,
    this.isExpanded = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 10);
    final radius = size.width / (isExpanded ? 4 : 2.9);
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    // Draw background arc
    final backgroundPaint = Paint()
      ..color = percentage == 0 
          ? const Color(0xFF6B6B7B) 
          : const Color(0xFFD1C4E0)
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
        final totalScore = subjects!.fold(
          0.0, 
          (sum, subject) => sum + subject.score,
        );

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