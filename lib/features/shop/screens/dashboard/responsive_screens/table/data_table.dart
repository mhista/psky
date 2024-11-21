import 'package:ahiaa_web/common/widgets/data_table/paginated_data_table.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import 'table_source.dart';

class DashBoardOrderTable extends StatelessWidget {
  const DashBoardOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    return KPaginationDataTable(
      minWidth: 700,
      tableHeight: 500,
      dataRowHeight: PSizes.xl * 1.2,
      source: OrderRows(),
      columns: const [
        DataColumn2(
          label: Text('Order ID'),
        ),
        DataColumn2(
          label: Text('Date'),
        ),
        DataColumn2(
          label: Text('Items'),
        ),
        DataColumn2(
          label: Text('Status'),
        ),
        DataColumn2(
          label: Text('Amount'),
        ),
      ],
    );
  }
}
