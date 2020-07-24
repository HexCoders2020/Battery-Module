import 'package:flutter/material.dart';
import 'package:module/main_screen.dart';


class DeviceRegister extends StatefulWidget {

  @override
  _DeviceRegisterState createState() => _DeviceRegisterState();
}

class _DeviceRegisterState extends State<DeviceRegister> {

  String userName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 30.0, right: 30.0),
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                onChanged: (value){
                 userName = value;
                },
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Name'
                ),
              ),
              RaisedButton(
                child: Text('Proceed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                color: Color(0xff262626),
                onPressed: (){
                   if(userName == '' ||  userName == null){
                     showAlert();
                   }
                   else {
                     Navigator.pop(context);
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context) => MainScreen(userName: userName,)));
                   }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showAlert(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('oops!',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
          ),
          ),
          content: Text(
            'Please enter a valid name',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                  'OK',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

}
