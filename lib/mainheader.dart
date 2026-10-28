import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:geolocator/geolocator.dart";

class MainHeaderWidget extends StatefulWidget {
  final ValueChanged<List<Map>> onDataChanged;

  const MainHeaderWidget({Key? key, required this.onDataChanged})
    : super(key: key);

  @override
  State<MainHeaderWidget> createState() => _MainHeaderWidgetState();
}

class _MainHeaderWidgetState extends State<MainHeaderWidget> {
  @override
  void initState() {
    super.initState();
    checkGpsState();
  }

  void updateData() {
    List<Map> pointData2 = pointData.sublist(0, _seconds).reversed.toList();
    widget.onDataChanged(pointData2);
  }

  void checkGpsState() {
    Geolocator.getCurrentPosition()
        .then((Position position) {
          changeGpsState(true);
          String str =
              "latitude: ${position.latitude}, longitude: ${position.longitude})";
          showMsg(str);
        })
        .catchError((e) {
          changeGpsState(false);
          print(e);
          showMsg(e.toString());
        });
  }

  void showMsg(String str) {
    final snackBar = SnackBar(content: Text(str));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isGpsEnabled = false;
  bool isStart = true;

  void changeGpsState(bool isGpsEnabled) {
    setState(() {
      this.isGpsEnabled = isGpsEnabled;
    });
  }

  List<Map> pointData = [
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

  Timer? _timer;
  int _seconds = 0;
  String title = '00:00:00';

  String getXX(int val) {
    return (val < 10 ? '0' : '') + val.toString();
  }

  void getTime() {
    // DateTime n = DateTime.now();
    int hh = _seconds ~/ 3600;
    int mm = _seconds ~/ 60;
    int ss = _seconds - 3600 * hh - 60 * mm;
    title = getXX(hh) + ':' + getXX(mm) + ':' + getXX(ss);
  }

  void btnStartStopPressed() {
    if (isStart) {
      //widget.onDataChanged('Новые данные из FirstChild');
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        getTime();
        //addPointData();
        updateData();
      });
    } else {
      _timer?.cancel();
    }
    setState(() {
      isStart = !isStart;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      isStart ? Colors.green : Colors.red,
                    ),
                  ),
                  onPressed: () {
                    btnStartStopPressed();
                  },
                  child: Text(isStart ? 'Старт' : 'Стоп'),
                ),
                SizedBox(width: 2),
                Text("$title", style: TextStyle(fontSize: 22)),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      isGpsEnabled ? Colors.green : Colors.red,
                    ),
                  ),
                  onPressed: () {
                    HapticFeedback.vibrate();
                    checkGpsState();
                  },
                  child: Text('V1'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
