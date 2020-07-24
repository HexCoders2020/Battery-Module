import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:module/preserve_info.dart';
import 'package:module/register_device.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(Module()));
}

class Module extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PreserveInfo(),
      child: MaterialApp(
        home: DeviceRegister(),
      ),
    );
  }
}

