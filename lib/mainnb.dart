import "package:flutter/material.dart";
import "package:forest_runner/point_data.dart";

import "battery.dart";
import "map_screen.dart";

class MainNavigationBar extends StatefulWidget {
  // final String data;
  final List<Map> pointData;

  MainNavigationBar({required this.pointData});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  int _selectedIndex = 1;

  List<Widget> get _widgetOptions => [
    new MapScreen(),
    new PointData(/*data: widget.data, */ pointData: widget.pointData),
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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
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
