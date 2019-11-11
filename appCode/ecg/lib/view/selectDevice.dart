import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeviceSelectionState();
  }
}

class DeviceSelectionState extends State<DeviceSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    style: TextStyle(fontSize: 20, color: Colors.blue),
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
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                )),
          ),
          Positioned(
              top: 300 * (MediaQuery.of(context).size.height) / 1792,
              left: 0,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: SizedBox(
                  height: (MediaQuery.of(context).size.height),
                  width: (MediaQuery.of(context).size.width),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.black.withOpacity(0.20),
                    ),
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 20, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'HC-05',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
