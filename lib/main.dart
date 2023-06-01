import 'package:flutter/material.dart';
import 'package:bluetooth_device_around/themes/info_text_style.dart';
import 'package:bluetooth_device_around/screens/device_connection.dart';
import 'package:bluetooth_device_around/screens/devices_from_scan.dart';
import 'package:bluetooth_device_around/screens/device_provision.dart';
import 'package:bluetooth_device_around/models/ble_device.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
      routes: {
        DevicesFromScanScreen.id: (context) => DevicesFromScanScreen(),
        DeviceProvisionScreen.id: (context) =>
            DeviceProvisionScreen(selectedDevice: BleDevice(
                deviceName: '', rssi: 0, ad: '', type: '', macId: ''))
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth test"),
        ),
        body: Container(
          color: Colors.blueGrey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                    'Push the button to start the scan, please refer to the instruction of your device:',
                    style: InfoTextStyle()
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, DevicesFromScanScreen.id);
                },
                child: Text(
                    "Start Scan",
                    style: InfoTextStyle()
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                  elevation: 2.0,
                  minimumSize: Size(double.infinity, 24),
                ),
              )
            ],
          ),
        ),
      );
   }
}
