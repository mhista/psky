import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard_controller.dart';

class PWeeklySales extends StatelessWidget {
  const PWeeklySales({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashBoardController());

    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Sales',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),

          // Graph
          SizedBox(
            height: 400,
            child: BarChart(
              BarChartData(
                  titlesData: buildFlTitlesData(),
                  borderData: FlBorderData(
                      show: true,
                      border: const Border(
                          top: BorderSide.none, right: BorderSide.none)),
                  gridData: const FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: true,
                      horizontalInterval: 200),
                  barGroups: controller.weeklySales
                      .asMap()
                      .entries
                      .map(
                        (entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                                toY: entry.value,
                                width: 30,
                                color: PColors.primary,
                                borderRadius: BorderRadius.circular(PSizes.sm))
                          ],
                        ),
                      )
                      .toList(),
                  groupsSpace: PSizes.spaceBtwItems,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (_) => PColors.secondary),
                    touchCallback: ResponsiveBreakpoints.of(context).isDesktop
                        ? (barTouchEvent, barTouchResponse) {}
                        : null,
                  )),
            ),
          ),
        ],
      ),
    );
  }

// build tiles title
  FlTitlesData buildFlTitlesData() {
    return FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  // Map index to the desired day of the week
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];

                  // Calculate the index and ensure it wraps around for the correct day
                  final index = value.toInt() % days.length;

                  // get the day corresponding to the calculated index
                  final day = days[index];

                  return SideTitleWidget(
                    axisSide: AxisSide.bottom,
                    space: 0,
                    child: Text(day),
                  );
                })),
        leftTitles: const AxisTitles(
          sideTitles:
              SideTitles(showTitles: true, interval: 200, reservedSize: 50),
        ),
        rightTitles:
            const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)));
  }
}
