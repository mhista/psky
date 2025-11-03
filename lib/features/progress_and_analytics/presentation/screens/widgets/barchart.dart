import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:responsive_framework/responsive_framework.dart';

// Model for chart data point
class PerformanceData {
  final String month;
  final double value;
  final Map<String, double>? details;

  PerformanceData({
    required this.month,
    required this.value,
    this.details,
  });
}

// Model for tooltip details
class TooltipDetails {
  final Map<String, double> subjects;

  TooltipDetails({required this.subjects});

  String getFormattedText() {
    return subjects.entries
        .map((e) => '${e.key}: ${e.value.toInt()}%')
        .join('\n');
  }
}

// Main Chart Widget
class PerformanceChart extends StatefulWidget {
  final List<PerformanceData> data;
  final Color barColor;
  final Color backgroundColor;
  final double? barWidth;
  final double threshold;
  final bool showLeftAxis;
  final bool enableHoverAnimation;

  const PerformanceChart({
    super.key,
    required this.data,
    this.barColor = const Color(0xFF6B5FCD),
    this.backgroundColor = const Color(0xFFE8E4F3),
    this.barWidth,
    this.threshold = 60,
    this.showLeftAxis = true,
    this.enableHoverAnimation = true,
  });

  @override
  State<PerformanceChart> createState() => _PerformanceChartState();
}

class _PerformanceChartState extends State<PerformanceChart> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveBreakpoints.of(context);
    final isMobile = responsive.isMobile;

    final effectiveBarWidth = widget.barWidth ?? (isMobile ? 20 : 55);

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        minY: 0,
        barTouchData: _buildBarTouchData(isMobile),
        titlesData: _buildTitlesData(isMobile),
        borderData: FlBorderData(show: false),
        gridData: _buildGridData(),
        barGroups: _buildBarGroups(effectiveBarWidth),
        backgroundColor: Colors.transparent,
      ),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  BarTouchData _buildBarTouchData(bool isMobile) {
    return BarTouchData(
      enabled: true,
      handleBuiltInTouches: true,
      touchCallback: widget.enableHoverAnimation
          ? (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (event is FlPointerHoverEvent ||
                    event is FlTapUpEvent ||
                    event is FlLongPressMoveUpdate) {
                  _hoveredIndex = barTouchResponse?.spot?.touchedBarGroupIndex;
                } else if (event is FlPanEndEvent ||
                    event is FlPointerExitEvent) {
                  _hoveredIndex = null;
                }
              });
            }
          : null,
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (group) => const Color(0xFF2D2D2D),
        tooltipBorderRadius: BorderRadius.circular(8),
        tooltipPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 8 : 12,
          vertical: isMobile ? 6 : 8,
        ),
        tooltipMargin: 8,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          final dataPoint = widget.data[group.x.toInt()];

          if (dataPoint.details == null) return null;

          return BarTooltipItem(
            '',
            const TextStyle(),
            children: [
              TextSpan(
                text: dataPoint.details!.entries
                    .map((e) => '${e.key}: ${e.value.toInt()}%')
                    .join('\n'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              // TextSpan(
              //   text: '\n\nSee more',
              //   style: TextStyle(
              //     color: Colors.white70,
              //     fontSize: isMobile ? 10 : 11,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }

  FlTitlesData _buildTitlesData(bool isMobile) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: isMobile ? 24 : 30,
          getTitlesWidget: (value, meta) {
            if (value.toInt() >= 0 && value.toInt() < widget.data.length) {
              return Padding(
                padding: EdgeInsets.only(top: isMobile ? 6.0 : 8.0),
                child: Text(
                  widget.data[value.toInt()].month,
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: isMobile ? 10 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: widget.showLeftAxis,
          reservedSize: 32,
          interval: 20,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toInt().toString(),
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: isMobile ? 10 : 12,
                fontWeight: FontWeight.w400,
              ),
            );
          },
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    );
  }

  FlGridData _buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: 20,
      getDrawingHorizontalLine: (value) {
        if (value == widget.threshold) {
          return const FlLine(
            color: Color(0xFF9B8FC9),
            strokeWidth: 2,
            dashArray: [8, 4],
          );
        }
        return const FlLine(
          color: Colors.transparent,
          strokeWidth: 0,
        );
      },
    );
  }

  List<BarChartGroupData> _buildBarGroups(double effectiveBarWidth) {
    return widget.data.asMap().entries.map((entry) {
      final index = entry.key;
      final dataPoint = entry.value;
      final isHovered = widget.enableHoverAnimation && _hoveredIndex == index;

      // Subtle bounce animation on hover
      final animatedValue = isHovered
          ? dataPoint.value * 0.98 // Slight dip effect
          : dataPoint.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: animatedValue,
            color: widget.barColor,
            width: effectiveBarWidth,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 100,
              color: widget.backgroundColor,
            ),
          ),
        ],
      );
    }).toList();
  }
}



// Alternative: Composable Chart Builder
class ChartBuilder {
  List<PerformanceData> _data = [];
  Color _barColor = const Color(0xFF6B5FCD);
  Color _backgroundColor = const Color(0xFFE8E4F3);
  double _barWidth = 32;
  double _threshold = 60;
  bool _showLeftAxis = true;
  bool _enableHoverAnimation = true;

  ChartBuilder withData(List<PerformanceData> data) {
    _data = data;
    return this;
  }

  ChartBuilder withBarColor(Color color) {
    _barColor = color;
    return this;
  }

  ChartBuilder withBackgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  ChartBuilder withBarWidth(double width) {
    _barWidth = width;
    return this;
  }

  ChartBuilder withThreshold(double threshold) {
    _threshold = threshold;
    return this;
  }

  ChartBuilder withLeftAxis(bool show) {
    _showLeftAxis = show;
    return this;
  }

  ChartBuilder withHoverAnimation(bool enable) {
    _enableHoverAnimation = enable;
    return this;
  }

  Widget build() {
    return PerformanceChart(
      data: _data,
      barColor: _barColor,
      backgroundColor: _backgroundColor,
      barWidth: _barWidth,
      threshold: _threshold,
      showLeftAxis: _showLeftAxis,
      enableHoverAnimation: _enableHoverAnimation,
    );
  }
}


