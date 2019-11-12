import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_ecg/model/MainModel.dart';
import 'package:real_time_ecg/view/homeScreen.dart';
import 'package:scoped_model/scoped_model.dart';

class DeviceSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeviceSelectionState();
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class DeviceSelectionState extends State<DeviceSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      if (!model.gotDevices) {
        model.getPairedDevices();
      }
      return Scaffold(
        body: !model.gotDevices
            ? CupertinoActivityIndicator()
            : model.devices.length > 0
                ? Stack(
                    children: <Widget>[
                      Positioned(
                        top: 120 * (MediaQuery.of(context).size.height) / 1792,
                        left: 20 * (MediaQuery.of(context).size.width) / 828,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Row(
                            children: <Widget>[
                              new Icon(
                                Icons.arrow_back_ios,
                                color: Colors.blue,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200 * (MediaQuery.of(context).size.height) / 1792,
                        left: 0,
                        child: SizedBox(
                            height: 40,
                            width: (MediaQuery.of(context).size.width),
                            child: Center(
                              child: Text(
                                'Select Device',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                              ),
                            )),
                      ),
                      Positioned(
                          top:
                              300 * (MediaQuery.of(context).size.height) / 1792,
                          left: 0,
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: SizedBox(
                                height: (MediaQuery.of(context).size.height),
                                width:
                                    (MediaQuery.of(context).size.width * .90),
                                child: ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                            color:
                                                Colors.black.withOpacity(0.20),
                                          ),
                                      itemCount: model.devices.length,
                                      itemBuilder: (context, index) => InkWell(
                                            onTap: () {
                                              model.setDevice(
                                                  model.devices[index].device);
                                              
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      CupertinoPageRoute<Null>(
                                                          builder: (context) =>
                                                              new HomeScreen()));
                                            },
                                            child: ListTile(
                                              leading: Icon(Icons.bluetooth),
                                              title: Text(model
                                                  .devices[index].device.name
                                                  .toString()),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                          )),
                                ),
                              )))
                    ],
                  )
                : Center(
                    child: Text(
                      'No Paired Devices',
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
