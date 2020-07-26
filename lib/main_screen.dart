import 'dart:async';
import 'dart:ui';

import 'package:battery/battery.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:module/preserve_info.dart';
import 'package:provider/provider.dart';

/// this screen appears when the user presses the proceed button in register_device_screen
class MainScreen extends StatefulWidget {
  MainScreen({this.userName}); /// when this screen is called then a variable is passed to it
  final String userName;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  Battery _battery = Battery(); /// creates a battery object
  String myNumber;
  String myName;
  bool exist;

  StreamSubscription<BatteryState> _batteryStateSubscription; /// creates a stream of BatteryState type which continuously listens to battery state

  /// when the state object of this class is created then this function is called first and executed
  @override
  void initState() {
    checkExistOrNot();
    _battery.batteryLevel.then((level) { /// this extracts the phone battery level
      Provider.of<PreserveInfo>(context, listen: false).batteryLevel = level; /// then it notifies each listener about it and stores it in the variable of preserved_info class
    });

    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) { /// this listens to battery state and returns a battery state
      _battery.batteryLevel.then((level) { ///inside this the battery level is calculated whenever the battery state changes
        Provider.of<PreserveInfo>(context, listen: false).batteryLevel = level;
        Provider.of<PreserveInfo>(context, listen: false).batteryState = state;
        Provider.of<PreserveInfo>(context, listen: false).getCurrentLocation(name: widget.userName, existOrNOt: exist);
      });
    });

    super.initState();
  }

  /// this function checks whether the name entered by user in register_device_screen exists in the database
void checkExistOrNot(){
    /// it takes the snapshot of data in database
  FirebaseDatabase.instance.reference().child('modules').once().then((DataSnapshot snapshot){

    Map<dynamic,dynamic> _map = snapshot.value; /// the data snapshot which is of HashMap type is stored in a map(_map)

      if (snapshot.value == null) { /// if the database is empty then the following part is executed and the flag(exist) value is set to false
        exist = false;
        Provider.of<PreserveInfo>(context, listen: false).savedUserName = widget.userName; /// then the variable of the ChangeNotifier class(preserved_info) is initialized with the name entered by user
        ///  and notifies to every listener
      }
      else if(_map.containsKey(widget.userName)){ /// checks if the user exists and set flag to true
        exist = true;
      }
      else{  /// in any other case flag is set to false
        exist = false;
        Provider.of<PreserveInfo>(context, listen: false).savedUserName = widget.userName;
      }

      return;

  });
}
 /// this is what is shown to the user when the above processes execute
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
