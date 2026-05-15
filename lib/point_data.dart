import 'package:flutter/material.dart';

class PointData extends StatelessWidget {
  // final String data;
  final List<Map> pointData;

  PointData({required this.pointData});

  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Expanded(child: ListView(children: [_createDataTable()])),
    );
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      sortColumnIndex: _currentSortColumn,
      sortAscending: _isSortAsc,
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text('№'),
        onSort: (columnIndex, _) {
          _currentSortColumn = columnIndex;
          if (_isSortAsc) {
            pointData.sort((a, b) => b['id'].compareTo(a['id']));
          } else {
            pointData.sort((a, b) => a['id'].compareTo(b['id']));
          }
          _isSortAsc = !_isSortAsc;
        },
      ),
      DataColumn(
        label: Text('Время'),
        onSort: (columnIndex, _) {
          _currentSortColumn = columnIndex;
          if (_isSortAsc) {
            pointData.sort((a, b) => b['title'].compareTo(a['title']));
          } else {
            pointData.sort((a, b) => a['title'].compareTo(b['title']));
          }
          _isSortAsc = !_isSortAsc;
        },
      ),
      DataColumn(
        label: Text('Расстояние'),
        onSort: (columnIndex, _) {
          _currentSortColumn = columnIndex;
          if (_isSortAsc) {
            pointData.sort((a, b) => b['author'].compareTo(a['author']));
          } else {
            pointData.sort((a, b) => a['author'].compareTo(b['author']));
          }
          _isSortAsc = !_isSortAsc;
        },
      ),
    ];
  }

  List<DataRow> _createRows() {
    return pointData
        .map(
          (book) => DataRow(
            cells: [
              DataCell(Text('#' + book['id'].toString())),
              DataCell(Text(book['title'])),
              DataCell(Text(book['author'])),
            ],
          ),
        )
        .toList();
  }
}
