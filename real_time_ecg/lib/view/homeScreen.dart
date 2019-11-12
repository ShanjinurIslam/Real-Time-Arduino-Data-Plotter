import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_time_ecg/model/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      if (model.isConnecting) {
        model.connect();
        print('object');
      }
      return Scaffold(
          body: model.isConnected
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Connected'),
                      RaisedButton(
                        child: Text('Send Data'),
                        onPressed: (){
                          model.sendMessage('1');
                        },
                      ),
                      RaisedButton(
                        child: Text('Disconnect'),
                        onPressed: (){
                          model.disConnect();
                          Navigator.of(context).pop();
                        },
                      )
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
