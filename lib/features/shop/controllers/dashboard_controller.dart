import 'package:ahiaa_web/utils/constants/enums.dart';
import 'package:ahiaa_web/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';

class DashBoardController extends GetxController {
  static DashBoardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  //  -- Order
  static final List<OrderModel> orders = [
    OrderModel(
        id: '74872j',
        status: OrderStatus.processing,
        totalAmount: 267,
        orderDate: DateTime(2024, 11, 14),
        deliveryDate: DateTime(2024, 4, 1)),
    OrderModel(
        id: '748711j',
        status: OrderStatus.shipped,
        totalAmount: 189,
        orderDate: DateTime(2024, 11, 15),
        deliveryDate: DateTime(2024, 4, 12)),
    OrderModel(
        id: '74874j',
        status: OrderStatus.delivered,
        totalAmount: 225,
        orderDate: DateTime(2024, 11, 16),
        deliveryDate: DateTime(2024, 11, 24)),
    OrderModel(
        id: '74875j',
        status: OrderStatus.processing,
        totalAmount: 300,
        orderDate: DateTime(2024, 11, 17),
        deliveryDate: DateTime.now()),
    OrderModel(
        id: '74876j',
        status: OrderStatus.cancelled,
        totalAmount: 120,
        orderDate: DateTime(2024, 11, 18),
        deliveryDate: DateTime.now()),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // CALCULATE WEEKLY SALES
  void _calculateWeeklySales() {
    // RESET WEEKLY SALES TO ZERO
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          PHelperFunctions.getStartOfWeek(order.orderDate);
      // check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // ensure the index is non-negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;

        debugPrint(
            'OrderDate: ${order.orderDate}, currentWeekDay: $orderWeekStart, index: $index');
      }
    }
    debugPrint('Weekly Sales: $weeklySales');
  }

  _calculateOrderStatusData() {
    // reset status data
    orderStatusData.clear();

    // Map to store total amount for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      // Count orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;

      // calculate the total amounts
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
  }

  // get display status name
  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.pending:
        return 'Pending';
      default:
        return 'Unknown';
    }
  }
}
