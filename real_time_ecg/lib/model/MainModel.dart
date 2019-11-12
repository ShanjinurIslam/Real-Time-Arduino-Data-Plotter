import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:real_time_ecg/controller/bluetoothController.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model {
  bool _gotState = false;
  bool _gotDevices = false;
  BluetoothController bluetoothController = new BluetoothController();
  List<DeviceWithAvailability> _devices = new List<DeviceWithAvailability>();
  BluetoothState _state;
  BluetoothDevice server;
  static final clientID = 0;
  static final maxMessageLength = 4096 - 3;
  BluetoothConnection connection;

  List<Message> messages = List<Message>();
  String _messageBuffer = '';

  bool isConnecting = true;
  bool isConnected = false;
  bool isDisconnecting = false;

  void getState() async {
    _state = await bluetoothController.getBluetoothState();
    _gotState = true;
    print(_state);
    notifyListeners();
  }

  void getPairedDevices() async {
    _devices = await bluetoothController.getPairedDevices();
    _gotDevices = true;
    print(_devices.length);
    notifyListeners();
  }

  void setDevice(BluetoothDevice device) {
    server = device;
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      messages.add(Message(
          1,
          backspacesCounter > 0
              ? _messageBuffer.substring(
                  0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index)));
      _messageBuffer = dataString.substring(index);
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    print(messages.length);
  }

  void disConnect() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
  }

  void connect() async {
    BluetoothConnection.toAddress(server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      this.isConnecting = false;
      this.isConnected = true ;
      notifyListeners();
      connection.input.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  void sendMessage(String text) async {
    text = text.trim();

    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text + "\r\n"));
        await connection.output.allSent;

        Future.delayed(Duration(milliseconds: 333)).then((_) {});
      } catch (e) {}
    }
  }

  BluetoothState get state => _state;
  bool get gotState => _gotState;
  bool get gotDevices => _gotDevices;

  List<DeviceWithAvailability> get devices => _devices;
}
