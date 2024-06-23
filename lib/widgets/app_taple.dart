import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AppTable extends StatelessWidget {
  final DataTableSource source;
  final List<DataColumn> columns;
  final double? minWidth;
  const AppTable(
      {super.key,
      required this.source,
      required this.columns,
      this.minWidth = 660});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
        columns: columns,
        headingRowColor:
            MaterialStatePropertyAll(Theme.of(context).primaryColor),
        headingTextStyle: TextStyle(color: Colors.white, fontSize: 16),
        border: TableBorder.all(),
        renderEmptyRowsInTheEnd: false,
        isHorizontalScrollBarVisible: true,
        columnSpacing: 10,
        minWidth: minWidth,
        source: source);
  }
}
