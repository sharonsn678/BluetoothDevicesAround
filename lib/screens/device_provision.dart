import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluetooth_device_around/models/ble_device.dart';
import 'package:bluetooth_device_around/themes/info_text_style.dart';

class DeviceProvisionScreen extends StatefulWidget {

  static const id = "device provision screen";

  DeviceProvisionScreen({required this.selectedDevice});

  BleDevice selectedDevice;

  @override
  State<DeviceProvisionScreen> createState() => _DeviceProvisionScreenState();
}

class _DeviceProvisionScreenState extends State<DeviceProvisionScreen> {

  @override
  Widget build(BuildContext context) {
    widget.selectedDevice = ModalRoute.of(context)!.settings.arguments as BleDevice;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Device infomation'),
      ),
        body:Center(
        child: Container(
      padding: const EdgeInsets.only(left: 30.0, top: 60.0, right: 30.0, bottom: 30.0),
      color: Colors.blueGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Device Name:",
                      style: fixedTextStyle(),
                      textAlign: TextAlign.left
                  ),
                  //Flexible(child:
                  Text(
                    widget.selectedDevice.deviceName,
                    style: InfoTextStyle(),
                    textAlign: TextAlign.left,
                  ),
                  //),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MAC ID:",
                  style: fixedTextStyle(),
                  textAlign: TextAlign.left
                  ),
                  Text(
                    widget.selectedDevice.macId,
                    style: InfoTextStyle(),
                      textAlign: TextAlign.center,
                  ),
                ],
              ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type:",
                style: fixedTextStyle(),

              ),
              Text(
                widget.selectedDevice.type,
                style: InfoTextStyle(),

              ),
            ],
          ),
          Row(
            children: [
              Text("rssi:  ",
                style: fixedTextStyle(),
                textAlign: TextAlign.left,
              ),
              Text(
                widget.selectedDevice.rssi.toString(),
                style: InfoTextStyle(),
              ),
            ],
          ),
        ],
      ),
        )
    )
    );
  }


}
