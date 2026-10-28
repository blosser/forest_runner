import "package:flutter/material.dart";

import "mainheader.dart";
import "mainnb.dart";

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  List<Map> _pointData = [];

  //String _sharedData = 'Начальное значение';

  // Метод, который вызывается из MainHeaderWidget
  void _updateData(List<Map> pointData) {
    setState(() {
      _pointData = pointData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центровка по вертикали
          children: [
            SizedBox(height: 30),
            SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: MainHeaderWidget(onDataChanged: _updateData),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: MainNavigationBar(
                        /*pointData: pointData2*/
                        pointData: _pointData,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
