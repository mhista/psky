import 'package:ahiaa_web/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../widgets/dashboard_cards.dart';
import '../../widgets/order_status.dart';
import '../../widgets/weekly_sales.dart';
import '../table/data_table.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),

              // CARDS
              const Column(
                children: [
                  TDashboardCard(
                      title: 'Sales total', subtitle: '\$370.8', stats: 25),
                  SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  TDashboardCard(
                      title: 'Average Order Value',
                      subtitle: '\$25',
                      stats: 15),
                  SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  TDashboardCard(
                      title: 'Total Orders', subtitle: '36', stats: 44),
                  SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                  TDashboardCard(
                      title: 'Sales total', subtitle: '25,098', stats: 2),
                  SizedBox(
                    height: PSizes.spaceBtwItems,
                  ),
                ],
              ),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),

              // Weekly sales section
              // GRAPHS

              // BAR GRAPH
              Column(
                children: [
                  const PWeeklySales(),
                  const SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),
                  // ORDERS
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Recent Orders',
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(
                          height: PSizes.spaceBtwSections,
                        ),
                        const DashBoardOrderTable()
                      ],
                    ),
                  ),
                ],
              ),

              // Order and order status section
              const Column(
                children: [
                  SizedBox(
                    height: PSizes.spaceBtwSections,
                  ),
                  // PIE CHART
                  OrderStatusPieChart(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
