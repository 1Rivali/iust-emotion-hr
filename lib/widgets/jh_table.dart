import 'package:flutter/material.dart';
import 'package:front/constants/app_colors.dart';

class JHTable extends StatelessWidget {
  const JHTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<DataColumn> columns;
  final List<DataRow> rows;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        dataRowMaxHeight: 150,
        dataRowMinHeight: 50,
        sortAscending: true,
        border: TableBorder.all(
          color: primaryColor,
          borderRadius: BorderRadius.circular(10),
          width: 2,
        ),
        columns: columns,
        rows: rows,
      ),
    );
  }
}
