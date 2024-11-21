import 'package:ahiaa_web/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/shop/controllers/dashboard_controller.dart';
import 'package:ahiaa_web/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashBoardController.orders[index];
    return DataRow2(cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(Get.context!)
            .textTheme
            .bodyLarge!
            .apply(color: PColors.info),
      )),
      DataCell(Text(order.formattedOrderDate)),
      const DataCell(Text('5 Items')),
      DataCell(TRoundedContainer(
        radius: PSizes.cardRadiusSm,
        padding: const EdgeInsets.symmetric(
            horizontal: PSizes.md - 1, vertical: PSizes.xs - 1),
        backgroundColor:
            PHelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
        child: Text(
          order.status.name.capitalize.toString(),
          style: TextStyle(
              color: PHelperFunctions.getOrderStatusColor(order.status),
              fontSize: 13),
        ),
      )),
      DataCell(Text('\$${order.totalAmount}')),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashBoardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
