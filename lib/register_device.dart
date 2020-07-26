import 'package:flutter/material.dart';
import 'package:module/main_screen.dart';

/// this screen appears after the app is loaded
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
              TextField(        /// this adds a text field where user enters his/her name
                autofocus: true,
                onChanged: (value){ /// this function listens to every change to the value entered in the text field
                 userName = value;  /// and stores the entered value to a variable
                },
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration( /// the hint text
                  hintText: 'Name'
                ),
              ),
              /// adds a button below the text field
              RaisedButton(
                child: Text('Proceed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),),
                color: Color(0xff262626),
                onPressed: (){                              /// handles the onPressed event when the user presses the button
                   if(userName == '' ||  userName == null){
                     showAlert();      /// adds the validation to the textField that it cannot be empty
                     /// if so then shows an alert popup
                   }
                   else {   /// else the user is taken to the MainScreen
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

  /// shows an alert popup when the user sets the text field vacant and presses proceed button
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
              onPressed: (){ /// when this button is pressed then the popup is dismissed
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

}
