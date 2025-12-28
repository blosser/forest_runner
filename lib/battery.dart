import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  final Battery _battery = Battery();
  int batLevel = 0;

  BatteryState? _batteryState;

  @override
  void initState() {
    super.initState();
    _battery.batteryState.then(_updateBatteryState);
    getBatteryLevel();
  }

  getBatteryLevel() {
    _battery.batteryLevel.then((batteryLevel) {
      batLevel = batteryLevel;
    });
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  MaterialColor getColor() {
    if (batLevel >= 50) return Colors.green;
    if (batLevel >= 20) return Colors.yellow;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$batLevel',
              style: TextStyle(
                fontSize: 200,
                fontWeight: FontWeight.bold,
                color: getColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
