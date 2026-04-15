import "package:flutter/material.dart";
import "package:yandex_maps_mapkit_lite/init.dart" as init;
import "package:yandex_maps_mapkit_lite/mapkit.dart";

import "battery.dart";
import "map_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init.initMapkit(
      apiKey: '0a07fa93-3d89-42f9-9862-f08c06dccd52'
  );
  mapkit.onStart();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Forest Runner',
      home: const NavigationBarExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavigationBarExample extends StatefulWidget {
  const NavigationBarExample({super.key});

  @override
  State<NavigationBarExample> createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    new MapScreen(),
    Text(
      'Search Page',
      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
    ),
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
      body: Center(
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
            label: 'Search',
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
