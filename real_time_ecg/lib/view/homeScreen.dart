import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_ecg/controller/bluetoothController.dart';
import 'package:real_time_ecg/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class EcgData {
  EcgData(this.time, this.value);
  final double time;
  final double value;
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      if (model.isConnecting) {
        model.connect();
      }

      final List<EcgData> list = model.messages.map((_message) {
        return new EcgData(_message.time, double.parse(_message.data));
      }).toList();

      return Scaffold(
          body: model.isConnected
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: Text('Start'),
                            onPressed: () {
                              model.sendMessage('text');
                            },
                          ),
                          RaisedButton(
                            child: Text('Disconnect'),
                            onPressed: () {
                              model.disConnect();
                              Navigator.of(context).pop();
                              model.isConnecting = true;
                              model.isConnected = false;
                            },
                          ),
                        ],
                      ),
                      Container(
                          child: SfCartesianChart(
                              primaryXAxis:
                                  CategoryAxis(), // Initialize category axis.
                              series: <LineSeries<EcgData, double>>[
                            // Initialize line series.
                            LineSeries<EcgData, double>(
                                dataSource: list,
                                xValueMapper: (EcgData value, _) => value.time,
                                yValueMapper: (EcgData value, _) => value.value)
                          ])),
                    ],
                  ),
                )
              : Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                    animating: true,
                  ),
                ));
    });
  }
}
