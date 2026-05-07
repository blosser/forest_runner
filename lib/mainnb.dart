import "dart:async";

import "package:flutter/material.dart";
import "package:forest_runner/point_data.dart";

import "battery.dart";
import "map_screen.dart";

class MainNavigationBar extends StatefulWidget {
  final String childContent;

  const MainNavigationBar({Key? key, required this.childContent}) : super(key: key);

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  List<Map> pointData = [];


  int _selectedIndex = 1;
  late List<Widget> _widgetOptions = <Widget>[
    new MapScreen(),
    new PointData(widget.childContent, pointData),
    new BatteryPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ), // Display the selected page
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Карта',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Данные',
          ),
          NavigationDestination(
            icon: Icon(Icons.battery_4_bar_rounded),
            selectedIcon: Icon(Icons.battery_4_bar_rounded),
            label: 'Батарея',
          ),
        ],
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final String content;

  const ChildWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueAccent.withOpacity(0.2),
      child: Text(
        content,
        //style: TextStyle(fontSize: 12),
      ),
    );
  }
}