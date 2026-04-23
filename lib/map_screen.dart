import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
// import "package:latlong2/latlong.dart";
import "package:yandex_maps_mapkit_lite/image.dart" as image_provider;
import "package:yandex_maps_mapkit_lite/mapkit.dart";
import "package:yandex_maps_mapkit_lite/yandex_map.dart";

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapWindow? _mapWindow;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static showMsg(BuildContext context, String str) {
    final snackBar = SnackBar(content: Text(str));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  getCurrentLocation(context);
                },
                child: Text('Где я?'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  final List<Point> points = [
                    Point(latitude: 59.936046, longitude: 30.326869),
                    Point(latitude: 59.938185, longitude: 30.32808),
                    Point(latitude: 59.937376, longitude: 30.33621),
                    Point(latitude: 59.934517, longitude: 30.335059),
                  ];
                  loadMarkers(points);
                },
                child: Text('Load'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    _mapWindow?.map.mapObjects.clear();
                  });
                },
                child: Text('Clear'),
              ),
            ],
          ),
        ),
      ),
      body: YandexMap(onMapCreated: (mapWindow) => _mapWindow = mapWindow),
    );
  }

  getCurrentLocation(BuildContext context) {
    Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true,
        )
        .then((Position position) {
          setState(() {
            String str =
                "latitude: ${position.latitude}, longitude: ${position.longitude})";
            showMsg(context, str);
            final List<Point> points = [
              Point(latitude: position.latitude, longitude: position.longitude),
            ];
            loadMarkers(points);
          });
        })
        .catchError((e) {
          showMsg(context, e.toString());
          print(e);
        });
  }

  loadMarkers(final List<Point> points) {
    final imageProvider = image_provider.ImageProvider.fromImageProvider(
      const AssetImage("assets/icons/map_point.png"),
    );
    final pinsCollection = _mapWindow?.map.mapObjects.addCollection();

    final listener = MapObjectTapListenerImpl(context);
    final polyline = Polyline(points);
    final polylineObject = _mapWindow?.map.mapObjects.addPolylineWithGeometry(
      polyline,
    );
    polylineObject
      ?..strokeWidth = 5.0
      ..setStrokeColor(Colors.grey)
      ..outlineWidth = 2.0
      ..outlineColor = Colors.black;

    points.forEach((point) {
      final placemark = pinsCollection?.addPlacemark()
        ?..geometry = point
        ..setIcon(imageProvider);

      placemark?.addTapListener(listener);
    });

    if (!points.isEmpty) {
      Point p = points[0];
      _mapWindow?.map.move(
        CameraPosition(
          Point(latitude: p.latitude, longitude: p.longitude),
          zoom: 15.0,
          azimuth: 0.0,
          tilt: 0.0,
        ),
      );
    }
  }
}

final class MapObjectTapListenerImpl implements MapObjectTapListener {
  BuildContext context;

  MapObjectTapListenerImpl(this.context);

  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    String str = "latitude: ${point.latitude}, longitude: ${point.longitude})";
    _MapScreenState.showMsg(context, str);
    return true;
  }
}
