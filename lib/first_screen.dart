import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:module/main_screen.dart';
import 'package:module/register_device.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with AfterLayoutMixin<FirstScreen>{
  Future checkScreen() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (preferences.getBool('seen') ?? false);

    if(_seen){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainScreen()));
    }else{
      await preferences.setBool('seen', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DeviceRegister()));
    }
  }
  @override
  void afterFirstLayout(BuildContext context) => checkScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: Text(
         'setting up...',
         style: TextStyle(
           fontWeight: FontWeight.w400,
           fontSize: 22.0,
         ),
       ),
     ),
    );
  }
}
