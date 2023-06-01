import 'package:flutter/material.dart';
import 'package:bluetooth_device_around/themes/info_text_style.dart';
import 'package:bluetooth_device_around/componentview/device_tile.dart';
import 'package:bluetooth_device_around/models/ble_device.dart';

class DeviceList extends StatelessWidget {
  final List<BleDevice> deviceData;
  final Function(BleDevice) configButtonCallback;

  DeviceList({required this.deviceData, required this.configButtonCallback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          BleDevice item = deviceData[index];

          return TextButton(
            child: Text(
              item.deviceName + " " + item.ad,
              style: InfoTextStyle()
            ),

            onPressed: () {
              print("tapped $item");
              configButtonCallback(item);
            },
          );
        },
        itemCount: deviceData.length,
    );

  }
}
