import 'dart:async';

import 'package:flutter/material.dart';

class PointData extends StatefulWidget {
  @override
  _PointData createState() => _PointData();
}

class _PointData extends State<PointData> {
  List<Map> _books = [
    {'id': 100, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 101, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 102, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 110, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 111, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 112, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 120, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 121, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 122, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 130, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 131, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 132, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 140, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 141, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 142, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 150, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 151, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 152, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
    {'id': 160, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 161, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 162, 'title': 'Git and GitHub', 'author': 'Merlin Nick'},
  ];
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  Timer? _timer;
  int _seconds = 0;
  String title = '00:00:00';

  String getXX(int val) {
    return (val < 10 ? '0' : '') + val.toString();
  }

  void getTime() {
    DateTime n = DateTime.now();
    int hh = _seconds ~/ 3600;
    int mm = _seconds ~/ 60;
    int ss = _seconds - 3600 * hh - 60 * mm;
    title = getXX(hh) + ':' + getXX(mm) + ':' + getXX(ss);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    _timer = Timer.periodic(const Duration(seconds: 1), (
                      timer,
                    ) {
                      setState(() {
                        _seconds++;
                        getTime();
                      });
                    });
                  },
                  child: Text('Старт'),
                ),
                SizedBox(width: 2),
                Text("$title", style: TextStyle(fontSize: 22)),
                SizedBox(width: 2),
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    _timer?.cancel();
                  },
                  child: Text('Стоп'),
                ),
              ],
            ),
          ),
        ),
        body: ListView(children: [_createDataTable()]),
      ),
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
        label: Text('ID'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              _books.sort((a, b) => b['id'].compareTo(a['id']));
            } else {
              _books.sort((a, b) => a['id'].compareTo(b['id']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(
        label: Text('BOOK'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              _books.sort((a, b) => b['title'].compareTo(a['title']));
            } else {
              _books.sort((a, b) => a['title'].compareTo(b['title']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
      DataColumn(
        label: Text('AUTHOR'),
        onSort: (columnIndex, _) {
          setState(() {
            _currentSortColumn = columnIndex;
            if (_isSortAsc) {
              _books.sort((a, b) => b['author'].compareTo(a['author']));
            } else {
              _books.sort((a, b) => a['author'].compareTo(b['author']));
            }
            _isSortAsc = !_isSortAsc;
          });
        },
      ),
    ];
  }

  List<DataRow> _createRows() {
    return _books
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
