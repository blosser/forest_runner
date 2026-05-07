import "dart:async";

import "package:flutter/material.dart";
import "package:forest_runner/point_data.dart";
import "package:yandex_maps_mapkit_lite/init.dart" as init;
import "package:yandex_maps_mapkit_lite/mapkit_factory.dart";

import "battery.dart";
import "mainnb.dart";
import "map_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(apiKey: '0a07fa93-3d89-42f9-9862-f08c06dccd52');
  mapkit.onStart();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Forest Runner',
      home: const MainWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {

  void updateChild() {
    setState(() {
      // Обновляем содержимое дочернего виджета
      childContent = "Обн!";
    });
  }

  String childContent = "Пер";
  List<Map> pointData2 = [];
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
    DateTime n = DateTime.now();
    int hh = _seconds ~/ 3600;
    int mm = _seconds ~/ 60;
    int ss = _seconds - 3600 * hh - 60 * mm;
    title = getXX(hh) + ':' + getXX(mm) + ':' + getXX(ss);
  }

  // void addPointData() {
  //   setState(() {
  //     childContent = "Обн!";
  //     pointData2 = pointData;
  //   });
  //   //wPointData = new PointData(pointData);
  //   //wPointData.setPointData(pointData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Center(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         ChildWidget(content: childContent),
      //         ElevatedButton(
      //           style: ButtonStyle(
      //             foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
      //           ),
      //           onPressed: () {
      //             updateChild();
      //             // _timer?.cancel();
      //             // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //             //   setState(() {
      //             //     _seconds++;
      //             //     getTime();
      //             //     addPointData();
      //             //   });
      //             // });
      //           },
      //           child: Text('Старт'),
      //         ),
      //         SizedBox(width: 2),
      //         Text("$title", style: TextStyle(fontSize: 22)),
      //         SizedBox(width: 2),
      //         ElevatedButton(
      //           style: ButtonStyle(
      //             foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
      //           ),
      //           onPressed: () {
      //             _timer?.cancel();
      //           },
      //           child: Text('Стоп'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body:
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ChildWidget(content: childContent),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                updateChild();
                // _timer?.cancel();
                // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                //   setState(() {
                //     _seconds++;
                //     getTime();
                //     addPointData();
                //   });
                // });
              },
              child: Text('Старт'),
            ),
            SizedBox(width: 2),
            Text("$title", style: TextStyle(fontSize: 22)),
            SizedBox(width: 2),
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                _timer?.cancel();
              },
              child: Text('Стоп'),
            ),
            MainNavigationBar(childContent: childContent), // Display the selected page
          ],
        ),
        //child: MainNavigationBar(childContent: childContent), // Display the selected page
      ),
    );
  }
}