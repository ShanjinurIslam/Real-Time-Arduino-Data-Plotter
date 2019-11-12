import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_ecg/view/selectDevice.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Welcome',
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
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
      )),
    );
  }
}
