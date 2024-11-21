import 'package:ahiaa_web/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/responsive_screens/table/data_table.dart';
import 'package:ahiaa_web/features/shop/screens/dashboard/widgets/order_status.dart';
import 'package:ahiaa_web/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../widgets/dashboard_cards.dart';
import '../../widgets/weekly_sales.dart';

class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

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
              const Row(
                children: [
                  Expanded(
                    child: TDashboardCard(
                        title: 'Sales total', subtitle: '\$370.8', stats: 25),
                  ),
                  SizedBox(
                    width: PSizes.spaceBtwItems,
                  ),
                  Expanded(
                      child: TDashboardCard(
                          title: 'Average Order Value',
                          subtitle: '\$25',
                          stats: 15)),
                  SizedBox(
                    width: PSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                        title: 'Total Orders', subtitle: '36', stats: 44),
                  ),
                  SizedBox(
                    width: PSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TDashboardCard(
                        title: 'Sales total', subtitle: '25,098', stats: 2),
                  ),
                ],
              ),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),
              // GRAPHS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // BAR GRAPH
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall),
                              const SizedBox(
                                height: PSizes.spaceBtwSections,
                              ),
                              const DashBoardOrderTable()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: PSizes.spaceBtwSections,
                  ),
                  // PIE CHART
                  const Expanded(
                    child: OrderStatusPieChart(),
                  )
                ],
              ),
              const SizedBox(
                height: PSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyData extends DataTableSource {
//   final controller = Get.put(DashBoardController());
//   @override
//   DataRow? getRow(int index) {
//     final data = controller.filteredDataList[index];

//     return DataRow2(
//         onTap: () {},
//         selected: controller.selectedRows[index],
//         onSelectChanged: (value) =>
//             controller.selectedRows[index] = value ?? false,
//         cells: [
//           DataCell(Text(data['Column1'] ?? '')),
//           DataCell(Text(data['Column2'] ?? '')),
//           DataCell(Text(data['Column3'] ?? '')),
//           DataCell(Text(data['Column4'] ?? '')),
//         ]);
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => controller.filteredDataList.length;

//   @override
//   int get selectedRowCount => 0;
// // }

// class DashBoardController extends GetxController {
//   var filteredDataList = <Map<String, String>>[].obs;
//   var dataList = <Map<String, String>>[].obs;

//   RxList<bool> selectedRows =
//       <bool>[].obs; //observable list to sort selected rows

//   RxInt sortByColumnIndex =
//       1.obs; // observable for tracking the index of the column fr sorting
//   RxBool sortAscending = true
//       .obs; // observable for tracking the sort order(ascending or descending)
//   final searchTextController =
//       TextEditingController(); // Controller for the search text;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDummyData();
//   }

//   void fetchDummyData() {
//     selectedRows.assignAll(List.generate(36, (index) => false));
//     filteredDataList.addAll(List.generate(
//         36,
//         (index) => {
//               'Column1': 'Data ${index + 1} - 1',
//               'Column2': 'Data ${index + 1} - 2',
//               'Column3': 'Data ${index + 1} - 3',
//               'Column4': 'Data ${index + 1} - 4',
//             }));
//     dataList.addAll(List.generate(
//         36,
//         (index) => {
//               'Column1': 'Data ${index + 1} - 1',
//               'Column2': 'Data ${index + 1} - 2',
//               'Column3': 'Data ${index + 1} - 3',
//               'Column4': 'Data ${index + 1} - 4',
//             }));
//   }

//   // sort by id
//   void sortById(int columnIndex, bool ascending) {
//     sortAscending.value = ascending;
//     filteredDataList.sort((a, b) => ascending
//         ? filteredDataList[0]['column1']
//             .toString()
//             .toLowerCase()
//             .compareTo(filteredDataList[0]['column1'].toString().toLowerCase())
//         : filteredDataList[0]['column1'].toString().toLowerCase().compareTo(
//             filteredDataList[0]['column1'].toString().toLowerCase()));

//     sortByColumnIndex.value = columnIndex;
//   }

//   // search query
//   void searchQuery(String query) {
//     filteredDataList.assignAll(dataList
//         .where((item) => item['column1']!.contains(query.toLowerCase())));
//   }
// }
