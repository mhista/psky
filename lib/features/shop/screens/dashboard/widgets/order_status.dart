import 'package:ahiaa_web/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ahiaa_web/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/shop/controllers/dashboard_controller.dart';
import 'package:ahiaa_web/utils/constants/enums.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OrderStatusPieChart extends StatelessWidget {
  const OrderStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashBoardController.instance;
    return TRoundedContainer(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: PSizes.spaceBtwSections,
          ),

          // graph
          SizedBox(
            height: 400,
            child: PieChart(
              PieChartData(
                  sections: controller.orderStatusData.entries.map((entry) {
                    final status = entry.key;
                    final count = entry.value;
                    return PieChartSectionData(
                        // showTitle: true,
                        radius: 100,
                        color: PHelperFunctions.getOrderStatusColor(status),
                        title: count.toString(),
                        value: count.toDouble(),
                        titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white));
                  }).toList(),
                  pieTouchData: PieTouchData(
                    touchCallback: (evnet, pieTouchResponse) {
                      // handle touch events
                    },
                    enabled: true,
                  )),
            ),
          ),
          // show order status
          SizedBox(
            width: double.infinity,
            child: DataTable(
              // clipBehavior: Clip.antiAlias,
              columns: const [
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Orders')),
                DataColumn(label: Text('Total')),
              ],
              rows: controller.orderStatusData.entries.map((entry) {
                final OrderStatus status = entry.key;
                final int count = entry.value;
                final totalAmount = controller.totalAmounts[status] ?? 0;
                return DataRow(cells: [
                  DataCell(Row(
                    children: [
                      PCircularContainer(
                        width: 20,
                        height: 20,
                        backgroundColor:
                            PHelperFunctions.getOrderStatusColor(status),
                      ),
                      Expanded(
                          child: Text(
                              ' ${controller.getDisplayStatusName(status)}'))
                    ],
                  )),
                  DataCell(
                    Text('$count'),
                  ),
                  DataCell(
                    Text('\$${totalAmount.toStringAsFixed(2)}'),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
