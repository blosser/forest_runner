import "package:flutter/material.dart";
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
  int _counter = 0;
  MapWindow? _mapWindow;

  // late final MapController _mapController;
  // late List<Marker> markerList = [];
  // late List<LatLng> pointList = [];
  // late Position _currentPosition;

  @override
  void initState() {
    // _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    // _mapController.dispose();
    super.dispose();
  }

  // List<LatLng> get _mapPoints2 => const [
  //   LatLng(55.755793, 37.617134),
  //   LatLng(55.095960, 38.765519),
  //   LatLng(56.129038, 40.406502),
  //   LatLng(54.513645, 36.261268),
  //   LatLng(54.193122, 37.617177),
  //   LatLng(54.629540, 39.741809),
  // ];

  void _incrementCounter() {
    // setState(() {
    //   _counter++;
    //   markerList = _getMarkers(_mapPoints);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _getCurrentLocation();
                },
                child: Text('Где я?'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    // markerList = [];
                    // pointList = [];
                    _counter = 0;
                  });
                },
                child: Text('Очистить'),
              ),
              // SizedBox(width: 20),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              //   ),
              //   onPressed: _incrementCounter,
              //   child: Text('$_counter'),
              // ),
            ],
          ),
        ),
      ),
      body: YandexMap(onMapCreated: (mapWindow) => _mapWindow = mapWindow),
    );
  }

  //Чтобы изменить положение или масштаб карты, используйте метод
  // _mapWindow?.map.move(
  // CameraPosition(
  // Point(latitude: 55.751225, longitude: 37.62954),
  // zoom: 17.0,
  // azimuth: 150.0,
  // tilt: 30.0
  // )
  // );

  _getCurrentLocation() {
    final imageProvider = image_provider.ImageProvider.fromImageProvider(
      const AssetImage("assets/icons/map_point.png"),
    );
    final pinsCollection = _mapWindow?.map.mapObjects.addCollection();
    final points = [
      Point(latitude: 59.936046, longitude: 30.326869),
      Point(latitude: 59.938185, longitude: 30.32808),
      Point(latitude: 59.937376, longitude: 30.33621),
      Point(latitude: 59.934517, longitude: 30.335059),
    ];

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
      pinsCollection?.addPlacemark()
        ?..geometry = point
        ..setIcon(imageProvider)
        ..addTapListener(listener);
    });

    _mapWindow?.map.move(
      CameraPosition(
        Point(latitude: 59.936046, longitude: 30.326869),
        zoom: 15.0,
        azimuth: 150.0,
        tilt: 30.0,
      ),
    );

    // final placemark = _mapWindow?.map.mapObjects.addPlacemark()
    //   ?..geometry = const Point(latitude: 55.751225, longitude: 37.62954)
    //   ..setIcon(imageProvider)
    //   ..setIconStyle(
    //       const mapkit.IconStyle(
    //         anchor: math.Point(0.5, 1.0),
    //         scale: 1,
    //       ));

    // Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.best,
    //       forceAndroidLocationManager: true,
    //     )
    //     .then((Position position) {
    //       setState(() {
    //         // _currentPosition = position;
    //         _counter++;
    //         //List<LatLng> mPoints = [];
    //         //for (int i = 0; i < _counter; i++) {
    //         //mPoints.add(_mapPoints2[i]);
    //         //}
    //         // List<LatLng> _mapPoints = [
    //         //   LatLng(_currentPosition.latitude, _currentPosition.longitude),
    //         // ];
    //         // pointList.add(_mapPoints2[_counter - 1]);
    //         // markerList = _getMarkers(pointList);
    //         //markerList.addAll(mList);
    //       });
    //     })
    //     .catchError((e) {
    //       print(e);
    //     });
  }
}

/// Метод генерации маркеров
// List<Marker> _getMarkers(List<LatLng> mapPoints) {
//   return List.generate(
//     mapPoints.length,
//     (index) => Marker(
//       point: mapPoints[index],
//       child: Image.asset('assets/icons/map_point.png'),
//       width: 50,
//       height: 50,
//       alignment: Alignment.center,
//     ),
//   );
// }

/// Виджет для отображения кластера
// class _ClusterMarker extends StatelessWidget {
//   const _ClusterMarker({required this.markersLength});
//
//   /// Количество маркеров, объединенных в кластер
//   final String markersLength;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.blue[200],
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.blue, width: 3),
//       ),
//       child: Center(
//         child: Text(
//           markersLength,
//           style: TextStyle(
//             color: Colors.blue[900],
//             fontWeight: FontWeight.w700,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     );
//   }
// }

final class MapObjectTapListenerImpl implements MapObjectTapListener {
  BuildContext context;

  MapObjectTapListenerImpl(this.context);

  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    final str =
        "Tapped the placemark: Point(latitude: ${point.latitude}, longitude: ${point.longitude})";
    final snackBar = SnackBar(content: Text(str));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return true;
  }
}
