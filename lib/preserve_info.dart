import 'package:battery/battery.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

/// this class listens to every changes in it variable and notifies its every listener in the widget tree
class PreserveInfo extends ChangeNotifier {

  final databaseReference = FirebaseDatabase.instance.reference();

  String savedUserName;
  double myLat, myLong;

  int batteryLevel;
  BatteryState batteryState;
  String batteryStatus;

 /// this function calculates the users current location
  void getCurrentLocation({String name, bool existOrNOt}) async{
    Position _position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high); /// location is calculated using geolocator package
    myLat = _position.latitude;
    myLong = _position.longitude;

    batteryState == BatteryState.charging ? batteryStatus = 'Charging' : batteryStatus = 'Discharging';
   try{
     if(existOrNOt){  /// if the user already exists then its details are updated
       updateUserDetails(userName: name);
     }
     else{
       addToDatabase();  /// if user doesn't exists then his/her details are added to the database
     }
   }catch(e){
     print(e);
   }
  }

  /// function to add user details to database
  void addToDatabase(){
    databaseReference.child('modules').child(savedUserName).set({
      'location': [myLat,myLong],
      'battery' : batteryLevel,
      'status': batteryStatus,
      'userName': savedUserName,
    });
  }

  /// function to update user details in database
  void updateUserDetails({String userName}){

    databaseReference.child('modules').child(userName).update({
      'location': [myLat,myLong],
      'battery' : batteryLevel,
      'status': batteryStatus,
      'userName': userName,
    });
  }

}