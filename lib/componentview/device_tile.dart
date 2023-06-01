import 'package:flutter/material.dart';

class DeviceTile extends StatelessWidget {

  final VoidCallback configButtonCallback;
  final String deviceName;

  DeviceTile({required this.deviceName, required this.configButtonCallback});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: configButtonCallback,
      title: Text(
        deviceName,
      ),
    );}
}
