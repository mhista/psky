import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../loaders/animation_loader.dart';

class KPaginationDataTable extends StatelessWidget {
  const KPaginationDataTable({
    super.key,
    this.isDark = false,
    this.sortAscending = true,
    this.sortByColumnIndex,
    this.rowsPerPage = 10,
    required this.source,
    required this.columns,
    this.onPageChanged,
    this.dataRowHeight = 56,
    this.tableHeight = 1000,
    this.minWidth = 1000,
  });
  // check for dark mode
  final bool isDark;

  // whether to sort the datatable in ascending or descending order
  final bool sortAscending;
  // index of the column to be sorted by
  final int? sortByColumnIndex;
  // number of rows to display
  final int rowsPerPage;
  // the data to be displayed in the datatable
  final DataTableSource source;
  // list of columns for the datatable
  final List<DataColumn> columns;
  // callback function to handle page changes
  final void Function(int)? onPageChanged;
  // height of each data row in the datatable
  final double dataRowHeight;
  // height of the entire dataTable
  final double tableHeight;
  // minimum widthe of the entire dataTable
  final double minWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tableHeight,
      child: Theme(
        data: Theme.of(context).copyWith(
            cardTheme: CardTheme(
                color: isDark ? Colors.black : Colors.white, elevation: 0)),
        child: PaginatedDataTable2(
            columnSpacing: 12,
            minWidth: minWidth,
            dividerThickness: 0,
            horizontalMargin: 12,
            dataRowHeight: dataRowHeight,
            rowsPerPage: rowsPerPage,
            // empty: const AnimationLoaderWidget(
            //     text: 'Nothing found',
            //     animation: PImages.whops,
            //     height: 200,
            //     width: 200),
            headingTextStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 2),
            headingRowColor: WidgetStateProperty.resolveWith((states) => isDark
                ? PColors.dark
                : PColors.primaryBackground.withOpacity(0.7)),
            headingRowDecoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(PSizes.borderRadiusMd),
                  topRight: Radius.circular(PSizes.borderRadiusMd)),
            ),
            // checkbox column
            showCheckboxColumn: true,
            // PAGINATION
            showFirstLastButtons: true,
            onPageChanged: onPageChanged,
            renderEmptyRowsInTheEnd: true,
            onRowsPerPageChanged: (noOfRows) {},

            // SORTING
            sortAscending: sortAscending,
            sortArrowAlwaysVisible: true,
            sortArrowIcon: Icons.line_axis,
            sortColumnIndex: sortByColumnIndex,
            sortArrowBuilder: (ascending, sorted) {
              return sorted
                  ? Icon(ascending ? Iconsax.arrow_up_3 : Iconsax.arrow_down,
                      size: PSizes.iconSm)
                  : const Icon(Iconsax.arrow_3, size: PSizes.iconSm);
            },

            // decoration:
            //     BoxDecoration(color: Colors.white, border: Border.all()),
            columns: columns,
            source: source),
      ),
    );
  }
}
