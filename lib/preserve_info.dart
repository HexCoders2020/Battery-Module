import 'package:battery/battery.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';


class PreserveInfo extends ChangeNotifier {

  final databaseReference = FirebaseDatabase.instance.reference();

  String savedUserName;
  double myLat, myLong;

  int batteryLevel;
  BatteryState batteryState;
  String batteryStatus;


  void getCurrentLocation({String name, bool existOrNOt}) async{
    Position _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    myLat = _position.latitude;
    myLong = _position.longitude;

    batteryState == BatteryState.charging ? batteryStatus = 'Charging' : batteryStatus = 'Discharging';
   try{
     if(existOrNOt){
       updateUserDetails(userName: name);
     }
     else{
       addToDatabase();
     }
   }catch(e){
     print(e);
   }
  }

  void addToDatabase(){
    databaseReference.child('modules').child(savedUserName).set({
      'location': [myLat,myLong],
      'battery' : batteryLevel,
      'status': batteryStatus,
      'userName': savedUserName,
    });
  }

  void updateUserDetails({String userName}){

    databaseReference.child('modules').child(userName).update({
      'location': [myLat,myLong],
      'battery' : batteryLevel,
      'status': batteryStatus,
      'userName': userName,
    });
  }

}