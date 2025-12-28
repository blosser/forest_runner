import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _counter = 0;
  late final MapController _mapController;
  late List<Marker> markerList = [];
  late Position _currentPosition;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<LatLng> get _mapPoints => const [
    LatLng(55.755793, 37.617134),
    LatLng(55.095960, 38.765519),
    LatLng(56.129038, 40.406502),
    LatLng(54.513645, 36.261268),
    LatLng(54.193122, 37.617177),
    LatLng(54.629540, 39.741809),
  ];

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
                    markerList = [];
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
      body: FlutterMap(
        mapController: _mapController,
        options: const MapOptions(
          initialCenter: LatLng(55.755793, 37.617134),
          initialZoom: 10,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'forest_runner',
          ),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              size: const Size(50, 50),
              maxClusterRadius: 50,
              markers: markerList,
              builder: (_, markers) {
                return _ClusterMarker(markersLength: markers.length.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          forceAndroidLocationManager: true,
        )
        .then((Position position) {
          setState(() {
            _currentPosition = position;
            _counter++;
            List<LatLng> mPoints = [];
            for (int i = 0; i < _counter; i++) {
              mPoints.add(_mapPoints[i]);
            }
            // List<LatLng> _mapPoints = [
            //   LatLng(_currentPosition.latitude, _currentPosition.longitude),
            // ];
            markerList = _getMarkers(mPoints);
            //markerList.addAll(mList);
          });
        })
        .catchError((e) {
          print(e);
        });
  }
}

/// Метод генерации маркеров
List<Marker> _getMarkers(List<LatLng> mapPoints) {
  return List.generate(
    mapPoints.length,
    (index) => Marker(
      point: mapPoints[index],
      child: Image.asset('assets/icons/map_point.png'),
      width: 50,
      height: 50,
      alignment: Alignment.center,
    ),
  );
}

/// Виджет для отображения кластера
class _ClusterMarker extends StatelessWidget {
  const _ClusterMarker({required this.markersLength});

  /// Количество маркеров, объединенных в кластер
  final String markersLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[200],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 3),
      ),
      child: Center(
        child: Text(
          markersLength,
          style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
