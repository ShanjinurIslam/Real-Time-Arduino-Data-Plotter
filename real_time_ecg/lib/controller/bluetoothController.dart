import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

enum DeviceAvailability {
  no,
  maybe,
  yes,
}

class DeviceWithAvailability extends BluetoothDevice {
  BluetoothDevice device;
  DeviceAvailability availability;
  int rssi;
  DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class Message {
  int whom;
  String text;

  Message(this.whom, this.text);
}

class BluetoothController {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  List<DeviceWithAvailability> devices = List<DeviceWithAvailability>();
  Future<BluetoothState> getBluetoothState() async {
    await FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
    });
    return _bluetoothState;
  }

  Future<List<DeviceWithAvailability>> getPairedDevices() async {
    await FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices
          .map((device) =>
              DeviceWithAvailability(device, DeviceAvailability.yes))
          .toList();
    });

    return devices;
  }
}
