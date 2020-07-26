import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module/preserve_info.dart';
import 'package:module/register_device.dart';
import 'package:provider/provider.dart';

void main() {
  /// when the app starts then at that particular time the device orientation is set to portrait mode for the entire app
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(Module()));
}

class Module extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( /// this app makes use of provider package by flutter team to manage state
      create: (context) => PreserveInfo(),
      child: MaterialApp(
        home: DeviceRegister(),  /// the screen to appear after the app is launched
      ),
    );
  }
}

