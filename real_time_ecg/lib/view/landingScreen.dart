import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:real_time_ecg/model/MainModel.dart';
import 'package:real_time_ecg/view/selectDevice.dart';
import 'package:scoped_model/scoped_model.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      if (!model.gotState) {
        model.getState();
      }
      return Scaffold(
        backgroundColor: model.state == BluetoothState.STATE_ON
            ? Colors.white
            : Colors.black,
        body: !model.gotState
            ? CupertinoActivityIndicator()
            : model.state == BluetoothState.STATE_ON
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                      new RawMaterialButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute<Null>(
                              builder: (context) => new DeviceSelection()));
                        },
                        child: new Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                          size: 35.0,
                        ),
                        shape: new CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(15.0),
                      ),
                    ],
                  ))
                : Center(
                    child: Text(
                      'Bluetooth Not Available',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                  ),
      );
    });
  }
}
