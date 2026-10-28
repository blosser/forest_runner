import "package:flutter/material.dart";
import "package:yandex_maps_mapkit_lite/init.dart" as init;
import "package:yandex_maps_mapkit_lite/mapkit_factory.dart";

import "mainwidget.dart";

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
      home: MainWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
