import 'dart:async';
import 'dart:ui';

import 'package:battery/battery.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:module/preserve_info.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({this.userName});
  final String userName;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  Battery _battery = Battery();
  String myNumber;
  String myName;
  bool exist;

  StreamSubscription<BatteryState> _batteryStateSubscription;

  @override
  void initState() {
    checkExistOrNot();
    _battery.batteryLevel.then((level) {
      Provider.of<PreserveInfo>(context, listen: false).batteryLevel = level;
    });

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
      _battery.batteryLevel.then((level) {
        Provider.of<PreserveInfo>(context, listen: false).batteryLevel = level;
        Provider.of<PreserveInfo>(context, listen: false).batteryState = state;
        Provider.of<PreserveInfo>(context, listen: false).getCurrentLocation(name: widget.userName, existOrNOt: exist);
      });
    });

    super.initState();
  }

void checkExistOrNot(){
  FirebaseDatabase.instance.reference().child('modules').once().then((DataSnapshot snapshot){

    Map<dynamic,dynamic> _map = snapshot.value;

      if (snapshot.value == null) {
        exist = false;
        Provider.of<PreserveInfo>(context, listen: false).savedUserName = widget.userName;
      }
      else if(_map.containsKey(widget.userName)){
        exist = true;
      }
      else{
        exist = false;
        Provider.of<PreserveInfo>(context, listen: false).savedUserName = widget.userName;
      }

      return;

  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              SpinKitChasingDots(
                color: Colors.blue,
                size: 30.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'uploading details...',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
