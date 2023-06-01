import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bluetooth_device_around/screens/device_provision.dart';
import 'package:bluetooth_device_around/componentview/device_list.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:bluetooth_device_around/models/ble_device.dart';


class DevicesFromScanScreen extends StatefulWidget {
  const DevicesFromScanScreen({Key? key}) : super(key: key);
  static const id = "devices from scan screen";

  @override
  State<DevicesFromScanScreen> createState() => _DevicesFromScanScreenState();
}



class _DevicesFromScanScreenState extends State<DevicesFromScanScreen> {

  @override
  void initState() {
    super.initState();
    startBleScan();
  }

  List<BleDevice> result_devices = [];

  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  void startBleScan() async {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 6));

// Listen to scan results
    Set<String> result_temp = Set();
    var subscription = await flutterBlue.scanResults.listen((results) {

      // do something with scan results
      for (ScanResult r in results) {
        String deviceFound = r.device.name;

        if (deviceFound.isNotEmpty) {
          print('$deviceFound found! rssi: ${r.rssi}');
          String macId = r.device.id.toString();
          String dtype = r.device.type.name;
          BleDevice newDevice = BleDevice(deviceName: deviceFound, rssi: r.rssi, ad: '', type: dtype, macId: macId);
          if(r.advertisementData.serviceUuids != null && (r.advertisementData.serviceUuids.isNotEmpty) ){
            print(r.advertisementData.serviceUuids[0]);
            newDevice.ad = "(" + r.advertisementData.serviceUuids[0].toLowerCase()+ ")";
          }

          if(!result_temp.contains(newDevice.deviceName)){
            result_temp.add(newDevice.deviceName);
            setState(() {
              result_devices.add(newDevice);
            });
          }
        }
      }
    });

  }
  void stopScan()
  {
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: const Text('Scan devices'),
      ),
        body: Center(
        child: Container(
          padding:
              const EdgeInsets.only(top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
          color: Colors.blueGrey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.blueGrey,
                    radius: 30.0,
                    child: Icon(
                      Icons.bluetooth_audio,
                      size: 30.0,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  const Text(
                    'Found ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${result_devices.length} devices',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: DeviceList(
                    deviceData: result_devices,
                    configButtonCallback: (myDeivce){
                      Navigator.pushNamed(context, DeviceProvisionScreen.id,arguments: myDeivce);
                    }),
              ),
            ],
        ),
        )
        ),
        );
  }
}
